//
//  View_CompareFlow.swift
//  IntrathecalTherapyOptimization
//
//  Created by Jullian Cockerell on 8/22/18.
//  Copyright © 2018 RedRoosterDevelopment. All rights reserved.
//

import UIKit

class View_CompareFlow: UIViewController
{
    //General
    @IBOutlet weak var pageSelection: UISegmentedControl!
    @IBOutlet weak var overviewView: UIView!
    @IBOutlet weak var constantView: UIView!
    @IBOutlet weak var multirateView: UIView!
    @IBOutlet weak var periodicView: UIView!
    @IBOutlet weak var graphDisplay: UIImageView!
    
    
    //Overview Outlets
    @IBOutlet weak var showConstantSwitch: UISwitch!
    @IBOutlet weak var constantTotalDoseField: UISwitch!
    @IBOutlet weak var constantConvertDoseButton: UIButton!
    @IBOutlet weak var showPeriodicSwitch: UISwitch!
    @IBOutlet weak var periodicTotalDoseField: UITextField!
    @IBOutlet weak var perioidicConvertDoseButton: UIButton!
    @IBOutlet weak var showMultiRateSwitch: UISwitch!
    @IBOutlet weak var multiRateTotalDoseField: UITextField!
    @IBOutlet weak var multiRateConvertDoseButton: UIButton!
    @IBOutlet weak var masterConcentrationField: UITextField!
    @IBOutlet weak var masterConcentrationLabel: UILabel!
    @IBOutlet weak var dosePerClickField: UITextField!
    @IBOutlet weak var masterUnitSwitch: UISwitch!
    
    //Constant Outlets
    @IBOutlet weak var constantDoseSlider: UISlider!
    @IBOutlet weak var constantDoseInputField: AllowedCharsTextField!
    @IBOutlet weak var constantDoseInputLabel: UILabel!
    @IBOutlet weak var constantPumpRateField: UITextField!

    //Periodic Outlets
    @IBOutlet weak var periodicDoseSlider: UISlider!
    @IBOutlet weak var periodicDoseInputField: AllowedCharsTextField!
    @IBOutlet weak var periodicDoseInputLabel: UILabel!
    @IBOutlet weak var periodicBolusDurationPicker: UIDatePicker!
    @IBOutlet weak var periodicStartTimeField: UITextField!
    
    //MultiRate Outlets
    @IBOutlet weak var multiRateDoseSlider1: UISlider!
    @IBOutlet weak var multiRateDurationPicker1: UIDatePicker!
    @IBOutlet weak var multiRateDoseInputField1: AllowedCharsTextField!
    @IBOutlet weak var multiRateDoseInputLabel1: UILabel!
    @IBOutlet weak var multiRatePumpRateField1: UITextField!
    @IBOutlet weak var multiRateDoseSlider2: UISlider!
    @IBOutlet weak var multiRateDurationPicker2: UIDatePicker!
    @IBOutlet weak var multiRateDoseInputField2: AllowedCharsTextField!
    @IBOutlet weak var multiRateDoseInputLabel2: UILabel!
    @IBOutlet weak var multiRatePumpRateField2: UITextField!
    @IBOutlet weak var multiRateDoseSlider3: UISlider!
    @IBOutlet weak var multiRateDurationPicker3: UIDatePicker!
    @IBOutlet weak var multiRateDoseInputField3: AllowedCharsTextField!
    @IBOutlet weak var multiRateDoseInputLabel3: UILabel!
    @IBOutlet weak var multiRatePumpRateField3: UITextField!
    @IBOutlet weak var multiRateDoseSlider4: UISlider!
    @IBOutlet weak var multiRateDurationPicker4: UIDatePicker!
    @IBOutlet weak var multiRateDoseInputField4: AllowedCharsTextField!
    @IBOutlet weak var multiRateDoseInputLabel4: UILabel!
    @IBOutlet weak var multiRatePumpRateField4: UILabel!
    
    
    
    
    //MultiRate Functions
    
    @IBAction func multiRateDoseInputField4EDE(_ sender: AllowedCharsTextField) {
    }
    @IBAction func multiRateDoseInputField4EDB(_ sender: AllowedCharsTextField) {
    }
    @IBAction func multiRateDurationPicker4Changed(_ sender: UIDatePicker) {
    }
    @IBAction func multiRateDoseSlider4Changed(_ sender: UISlider) {
    }
    @IBAction func multiRateDoseInputField3EDE(_ sender: AllowedCharsTextField) {
    }
    @IBAction func multiRateDoseInputField3EDB(_ sender: AllowedCharsTextField) {
    }
    @IBAction func multiRateDurationPicker3Changed(_ sender: UISlider) {
    }
    @IBAction func multiRateDoseSlider3Changed(_ sender: UISlider) {
    }
    @IBAction func multiRateDoseInputField2EDE(_ sender: AllowedCharsTextField) {
    }
    @IBAction func multiRateDoseInputField2EDB(_ sender: AllowedCharsTextField) {
    }
    @IBAction func multiRateDurationPicker2Changed(_ sender: UIDatePicker) {
    }
    @IBAction func multiRateDoseSlider2Changed(_ sender: UISlider) {
    }
    @IBAction func multiRateDoseInputField1EDE(_ sender: AllowedCharsTextField) {
    }
    @IBAction func multiRateDoseInputField1EDB(_ sender: AllowedCharsTextField) {
    }
    @IBAction func multiRateDurationPicker1Changed(_ sender: UIDatePicker) {
    }
    @IBAction func multiRateDoseSlider1Changed(_ sender: UISlider) {
    }
    
    
    
    
    
    //Periodic Functions
    @IBAction func periodicStartTimeFieldEDE(_ sender: UITextField) {
    }
    @IBAction func periodicStartTimeFieldEDB(_ sender: UITextField) {
    }
    @IBAction func periodicBolusDurationPickerChanged(_ sender: UIDatePicker) {
    }
    @IBAction func periodicDoseSliderChanged(_ sender: UISlider) {
    }
    @IBAction func periodicDoseInputFieldEDB(_ sender: AllowedCharsTextField) {
    }
    @IBAction func periodicDoseInputFieldEDE(_ sender: AllowedCharsTextField) {
    }
    
    
    
    
    //Constant Functions
    @IBAction func constantDoseInputFieldEDE(_ sender: AllowedCharsTextField) {
    }
    @IBAction func constantDoseInputFieldEDB(_ sender: AllowedCharsTextField) {
    }
    @IBAction func constantDoseSliderChanged(_ sender: UISlider) {
    }
    
    //Overview Functions
    @IBAction func masterUnitSwitchFlipped(_ sender: UISwitch) {
    }
    @IBAction func dosePerClickFieldEDE(_ sender: UITextField) {
    }
    @IBAction func dosePerClickFieldEDB(_ sender: UITextField) {
    }
    @IBAction func masterConcentrationFieldEDE(_ sender: UITextField) {
    }
    @IBAction func masterConcentrationFieldEDB(_ sender: UITextField) {
    }
    @IBAction func showConstantSwitchFlipped(_ sender: UISwitch) {
    }
    @IBAction func constantConvertDoseButtonTouched(_ sender: UIButton) {
    }
    @IBAction func constantTotalDoseFieldEDB(_ sender: UITextField) {
    }
    @IBAction func constantTotalDoseFieldEDE(_ sender: UITextField) {
    }
    @IBAction func showPeriodicSwitchFlipped(_ sender: UISwitch) {
    }
    @IBAction func periodicTotalDoseFieldEDB(_ sender: UITextField) {
    }
    @IBAction func periodicTotalDoseFieldEDE(_ sender: UITextField) {
    }
    @IBAction func periodicConvertDoseButtonTouched(_ sender: UIButton) {
    }
    @IBAction func showMultiRateSwitchFlipped(_ sender: UISwitch) {
    }
    @IBAction func multiRateTotalDoseFieldEDB(_ sender: UITextField) {
    }
    @IBAction func multiRateTotalDoseFieldEDE(_ sender: UITextField) {
    }
    @IBAction func multiRateConvertDoseButtonTouched(_ sender: Any) {
    }
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pageSelectionChanged(_ sender: UISegmentedControl)
    {
        let pageChoice = pageSelection.selectedSegmentIndex
        
        if(pageChoice == 0)
        {
            overviewView.alpha = 1.0
            constantView.alpha = 0.0
            periodicView.alpha = 0.0
            multirateView.alpha = 0.0
        }
        else if(pageChoice == 1)
        {
            overviewView.alpha = 0.0
            constantView.alpha = 1.0
            periodicView.alpha = 0.0
            multirateView.alpha = 0.0
        }
        else if(pageChoice == 2)
        {
            overviewView.alpha = 0.0
            constantView.alpha = 0.0
            periodicView.alpha = 1.0
            multirateView.alpha = 0.0
        }
        else if(pageChoice == 3)
        {
            overviewView.alpha = 0.0
            constantView.alpha = 0.0
            periodicView.alpha = 0.0
            multirateView.alpha = 1.0
        }
    }

}
