//
//  SettingsViewController.swift
//  Geo-App
//
//  Created by Daniel Newell on 5/18/17.
//  Copyright © 2017 Daniel Newell. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var distanceUnitsLbl: UILabel!
    @IBOutlet weak var bearingUnitsLbl: UILabel!
    
    @IBOutlet weak var bearingSettingPicker: UIPickerView!
    @IBOutlet weak var distanceSettingPicker: UIPickerView!

    var distances = ["Kilometers", "Meters"]
    var bearings = ["Degrees", "Mils"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        distanceSettingPicker.delegate = self
        distanceSettingPicker.dataSource = self
        
        bearingSettingPicker.delegate = self
        bearingSettingPicker.dataSource = self
        
        let tapDistance = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.distanceClick))
        distanceUnitsLbl.isUserInteractionEnabled = true
        distanceUnitsLbl.addGestureRecognizer(tapDistance)
        
        let tapBearing = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.bearingClick))
        bearingUnitsLbl.isUserInteractionEnabled = true
        bearingUnitsLbl.addGestureRecognizer(tapBearing)
        
        bearingSettingPicker.isHidden = true
        distanceSettingPicker.isHidden = true
    }
    
    func distanceClick(sender:UITapGestureRecognizer) {
        distanceSettingPicker.isHidden = false
        bearingSettingPicker.isHidden = true
    }
    
    func bearingClick(sender:UITapGestureRecognizer) {
        distanceSettingPicker.isHidden = true
        bearingSettingPicker.isHidden = false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == distanceSettingPicker) {
            return distances[row]
        } else {
            return bearings[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == distanceSettingPicker) {
            distanceUnitsLbl.text = distances[row]
            distanceSettingPicker.isHidden = true
        } else {
            bearingUnitsLbl.text = bearings[row]
            bearingSettingPicker.isHidden = true
        }
        
    }
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        //TODO: This needs to save the settings and segue to view controller
    }
}
