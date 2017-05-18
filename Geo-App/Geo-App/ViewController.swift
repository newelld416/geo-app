//
//  ViewController.swift
//  Geo-App
//
//  Created by Daniel Newell on 5/17/17.
//  Copyright © 2017 Daniel Newell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var distanceText: UILabel!
    @IBOutlet weak var bearingText: UILabel!
    @IBOutlet weak var latitudeP1: UITextField!
    @IBOutlet weak var longitudeP1: UITextField!
    @IBOutlet weak var latitudeP2: UITextField!
    @IBOutlet weak var longitudeP2: UITextField!
    
    var distancePkrViewData = ["Kilometers", "Meters"]
    var bearingPkrViewData = ["Degrees", "Mils"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dismiss keyboard when tapping outside oftext fields
        let detectTouch = UITapGestureRecognizer(target: self, action:
            #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(detectTouch)
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func clearAction(_ sender: UIButton) {
        latitudeP1.text = ""
        longitudeP1.text = ""
        latitudeP2.text = ""
        longitudeP2.text = ""
        
        distanceText.text = "Distance:"
        bearingText.text = "Bearing:"
    }
    
    
    @IBAction func calculateAction(_ sender: UIButton) {
        let la1 = Double(latitudeP1.text!) ?? 0
        let la2 = Double(latitudeP2.text!) ?? 0
        let lo1 = Double(longitudeP1.text!) ?? 0
        let lo2 = Double(longitudeP2.text!) ?? 0
        
        let distance = haversineDinstance(la1: la1, lo1: lo1, la2:la2, lo2: lo2) / 1000
        let bearing = getBearing(la1: la1, lo1: lo1, la2:la2, lo2: lo2)
        
        let divisor = pow(10.0, Double(2))
        let roundedDistance = (distance * divisor).rounded() / divisor
        let roundedBearing = (bearing * divisor).rounded() / divisor
        
        distanceText.text = "Distance: \(roundedDistance) kilometers."
        bearingText.text = "Bearing: \(roundedBearing) degrees."
        
    }
    
    func haversineDinstance(la1: Double, lo1: Double, la2: Double, lo2: Double, radius: Double = 6367444.7) -> Double {
        let haversin = { (angle: Double) -> Double in
            return (1 - cos(angle))/2
        }
        
        let ahaversin = { (angle: Double) -> Double in
            return 2*asin(sqrt(angle))
        }
        
        // Converts from degrees to radians
        let dToR = { (angle: Double) -> Double in
            return (angle / 360) * 2 * Double.pi
        }
        
        let lat1 = dToR(la1)
        let lon1 = dToR(lo1)
        let lat2 = dToR(la2)
        let lon2 = dToR(lo2)
        
        return radius * ahaversin(haversin(lat2 - lat1) + cos(lat1) * cos(lat2) * haversin(lon2 - lon1))
    }
    
    func radians(n: Double) -> Double{
        return n * (Double.pi / 180);
    }
    
    func degrees(n: Double) -> Double{
        return n * (180 / Double.pi);
    }
    
    func logC(val:Double,forBase base:Double) -> Double {
        return log(val)/log(base);
    }
    
    func getBearing(la1: Double, lo1:Double, la2: Double, lo2: Double) -> Double{
        var s_LAT: Double , s_LON: Double, e_LAT: Double, e_LON: Double, d_LONG: Double, d_PHI: Double;
        
        s_LAT = la1;
        s_LON = lo1;
        e_LAT = la2;
        e_LON = lo2;
        
        d_LONG = e_LON - s_LON;
        
        d_PHI = logC(val: tan(e_LAT/2.0+Double.pi/4.0)/tan(s_LAT/2.0+Double.pi/4.0),forBase :M_E);
        if (abs(d_LONG) > Double.pi){
            if(d_LONG>0.0){ d_LONG = -(2.0 * Double.pi - d_LONG); }
            else { d_LONG = (2.0 * Double.pi - d_LONG); }
        }
        return degrees(n: atan2(d_LONG, d_PHI)+360.0).truncatingRemainder(dividingBy: 360.0);
    }
}
