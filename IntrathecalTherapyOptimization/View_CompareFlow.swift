//
//  View_CompareFlow.swift
//  IntrathecalTherapyOptimization
//
//  Created by Jullian Cockerell on 8/22/18.
//  Copyright © 2018 RedRoosterDevelopment. All rights reserved.
//

import UIKit

class View_CompareFlow: UIViewController, UITextFieldDelegate
{
    var accumVol = Float(0.0025)
    var yLabelMax = Float(0.07)
    var startHour = Float(0)
    var startMinute = Float(0)
    var mgMode = true
    var textHolder = ""
    var constantShow = true
    var periodicShow = true
    var multirateShow = true
    var prevStepperVal = 1
    var hour1 = Float(0)
    var hour2 = Float(0)
    var hour3 = Float(0)
    var hour4 = Float(0)
    var minute1 = Float(0)
    var minute2 = Float(0)
    var minute3 = Float(0)
    var minute4 = Float(0)
    var unitLabel = "mg"
    

    //General
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageSelection: UISegmentedControl!
    @IBOutlet weak var overviewView: UIView!
    @IBOutlet weak var constantView: UIView!
    @IBOutlet weak var multirateView: UIView!
    @IBOutlet weak var periodicView: UIView!
    @IBOutlet weak var graphDisplay: UIImageView!
    @IBOutlet weak var graphBorder: UIView!
    weak var constantShapeLayer: CAShapeLayer?
    weak var periodicShapeLayer: CAShapeLayer?
    weak var multiRateShapeLayer: CAShapeLayer?
    
    //Overview Outlets
    @IBOutlet weak var showConstantSwitch: UISwitch!
    @IBOutlet weak var constantConvertDoseButton: UIButton!
    @IBOutlet weak var constantTotalDoseField: UITextField!
    @IBOutlet weak var showPeriodicSwitch: UISwitch!
    @IBOutlet weak var periodicTotalDoseField: UITextField!
    @IBOutlet weak var perioidicConvertDoseButton: UIButton!
    @IBOutlet weak var showMultirateSwitch: UISwitch!
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
    @IBOutlet weak var periodicBolusStepper: UIStepper!
    @IBOutlet weak var periodicBolusNumLabel: UILabel!
    @IBOutlet weak var periodicDurationPicker: UIDatePicker!
    
    
    
    //MultiRate Outlets
    @IBOutlet weak var multiratePeriodStepper: UIStepper!
    @IBOutlet weak var multiratePeriodLabel: UILabel!
    @IBOutlet weak var multirateDoseSlider1: UISlider!
    @IBOutlet weak var multirateDoseField1: AllowedCharsTextField!
    @IBOutlet weak var multirateDoseLabel1: UILabel!
    @IBOutlet weak var multirateStartField1: UITextField!
    @IBOutlet weak var multirateDoseSlider2: UISlider!
    @IBOutlet weak var multirateDoseField2: AllowedCharsTextField!
    @IBOutlet weak var multirateDoseLabel2: UILabel!
    @IBOutlet weak var multirateStartField2: UITextField!
    @IBOutlet weak var multirateDoseSlider3: UISlider!
    @IBOutlet weak var multirateDoseField3: AllowedCharsTextField!
    @IBOutlet weak var multirateDoseLabel3: UILabel!
    @IBOutlet weak var multirateStartField3: UITextField!
    @IBOutlet weak var multirateDoseSlider4: UISlider!
    @IBOutlet weak var multirateDoseField4: AllowedCharsTextField!
    @IBOutlet weak var multirateDoseLabel4: UILabel!
    @IBOutlet weak var multirateStartField4: UITextField!
    @IBOutlet weak var multirateControlStack3: UIStackView!
    @IBOutlet weak var multirateControlStack4: UIStackView!
    

    
    
    //Overview Functions
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
    
    @IBAction func constantGraphSwitchChanged(_ sender: Any)
    {
        constantShow = showConstantSwitch.isOn
        updateConstant()
    }
    
    @IBAction func periodicGraphSwitchChanged(_ sender: Any)
    {
        periodicShow = showPeriodicSwitch.isOn
        updatePeriodic()
    }
    
    @IBAction func multirateGraphSwitchChanged(_ sender: Any)
    {
        multirateShow = showMultirateSwitch.isOn
        updateMultirate()
    }
    
    
    //Multirate Functions
    func dismissPicker1()
    {
        activateInputs()
        view.endEditing(true)
        let components = Calendar.current.dateComponents([.hour, .minute], from: datePicker.date)
        hour1 = Float(components.hour!)
        minute1 = Float(components.minute!)
        multirateStartField1.text = dateFormatter.string(from: datePicker.date)
        updateMultirate()
    }
    
    func dismissPicker2()
    {
        activateInputs()
        view.endEditing(true)
        let components = Calendar.current.dateComponents([.hour, .minute], from: datePicker.date)
        hour2 = Float(components.hour!)
        minute2 = Float(components.minute!)
        multirateStartField2.text = dateFormatter.string(from: datePicker.date)
        updateMultirate()
    }
    
    func dismissPicker3()
    {
        activateInputs()
        view.endEditing(true)
        let components = Calendar.current.dateComponents([.hour, .minute], from: datePicker.date)
        hour3 = Float(components.hour!)
        minute3 = Float(components.minute!)
        multirateStartField3.text = dateFormatter.string(from: datePicker.date)
        updateMultirate()
    }
    
    func dismissPicker4()
    {
        activateInputs()
        view.endEditing(true)
        let components = Calendar.current.dateComponents([.hour, .minute], from: datePicker.date)
        hour4 = Float(components.hour!)
        minute4 = Float(components.minute!)
        multirateStartField4.text = dateFormatter.string(from: datePicker.date)
        updateMultirate()
    }
    
    @IBAction func multiratePeriodStepperChanged(_ sender: Any)
    {
        let stepperState = Int(multiratePeriodStepper.value)
        multiratePeriodLabel.text = "\(stepperState)"
        if(stepperState == 2)
        {
            multirateControlStack3.isUserInteractionEnabled = false
            multirateControlStack4.isUserInteractionEnabled = false
            multirateStartField1.text = "00:00"
            hour1 = 0
            minute1 = 0
            multirateStartField2.text = "12:00"
            hour2 = 12
            minute2 = 0
            UIView.animate(withDuration: 0.5, animations:
                {
                    self.multirateControlStack3.alpha = 0.0
                    self.multirateControlStack4.alpha = 0.0
            })
        }
        else if(stepperState == 3)
        {
            multirateControlStack3.isUserInteractionEnabled = true
            multirateControlStack4.isUserInteractionEnabled = false
            multirateStartField1.text = "00:00"
            hour1 = 0
            minute1 = 0
            multirateStartField2.text = "8:00"
            hour2 = 8
            minute2 = 0
            multirateStartField3.text = "16:00"
            hour3 = 16
            minute3 = 0
            UIView.animate(withDuration: 0.6, animations:
                {
                    self.multirateControlStack3.alpha = 1.0
                    self.multirateControlStack4.alpha = 0.0
            })
        }
        else if(stepperState == 4)
        {
            multirateControlStack3.isUserInteractionEnabled = true
            multirateControlStack4.isUserInteractionEnabled = true
            multirateStartField1.text = "00:00"
            hour1 = 0
            minute1 = 0
            multirateStartField2.text = "6:00"
            hour2 = 6
            minute2 = 0
            multirateStartField3.text = "12:00"
            hour3 = 12
            minute3 = 0
            multirateStartField4.text = "18:00"
            hour4 = 18
            minute4 = 0
            UIView.animate(withDuration: 0.6, animations:
                {
                    self.multirateControlStack3.alpha = 1.0
                    self.multirateControlStack4.alpha = 1.0
            })
        }
        updateMultirate()
    }
    
    @IBAction func multirateSliderChanged1(_ sender: Any)
    {
        if(!mgMode)
        {
            var doseInt = Int(multirateDoseSlider1.value)
            doseInt = doseInt - (doseInt % 5)
            multirateDoseSlider1.value = Float(doseInt)
            var doseValue = "\(multirateDoseSlider1.value)"
            doseValue = roundValue(inputText: doseValue, roundTo: 1)
            multirateDoseField1.text = doseValue
        }
        else
        {
            let inputText = "\(multirateDoseSlider1.value)"
            let inputPrefix = roundValue(inputText: inputText, roundTo: 1)
            let inputFloat = (inputPrefix as NSString).floatValue
            multirateDoseSlider1.value = inputFloat
            multirateDoseField1.text = inputPrefix
        }
        updateMultirate()
    }
    @IBAction func multirateSliderChanged2(_ sender: Any)
    {
        if(!mgMode)
        {
            var doseInt = Int(multirateDoseSlider2.value)
            doseInt = doseInt - (doseInt % 5)
            multirateDoseSlider2.value = Float(doseInt)
            var doseValue = "\(multirateDoseSlider2.value)"
            doseValue = roundValue(inputText: doseValue, roundTo: 1)
            multirateDoseField2.text = doseValue
        }
        else
        {
            let inputText = "\(multirateDoseSlider2.value)"
            let inputPrefix = roundValue(inputText: inputText, roundTo: 1)
            let inputFloat = (inputPrefix as NSString).floatValue
            multirateDoseSlider2.value = inputFloat
            multirateDoseField2.text = inputPrefix
        }
        updateMultirate()
    }
    @IBAction func multirateSliderChanged3(_ sender: Any)
    {
        if(!mgMode)
        {
            var doseInt = Int(multirateDoseSlider3.value)
            doseInt = doseInt - (doseInt % 5)
            multirateDoseSlider3.value = Float(doseInt)
            var doseValue = "\(multirateDoseSlider3.value)"
            doseValue = roundValue(inputText: doseValue, roundTo: 1)
            multirateDoseField3.text = doseValue
        }
        else
        {
            let inputText = "\(multirateDoseSlider3.value)"
            let inputPrefix = roundValue(inputText: inputText, roundTo: 1)
            let inputFloat = (inputPrefix as NSString).floatValue
            multirateDoseSlider3.value = inputFloat
            multirateDoseField3.text = inputPrefix
        }
        updateMultirate()
    }
    @IBAction func multirateSliderChanged4(_ sender: Any)
    {
        if(!mgMode)
        {
            var doseInt = Int(multirateDoseSlider4.value)
            doseInt = doseInt - (doseInt % 5)
            multirateDoseSlider4.value = Float(doseInt)
            var doseValue = "\(multirateDoseSlider4.value)"
            doseValue = roundValue(inputText: doseValue, roundTo: 1)
            multirateDoseField4.text = doseValue
        }
        else
        {
            let inputText = "\(multirateDoseSlider4.value)"
            let inputPrefix = roundValue(inputText: inputText, roundTo: 1)
            let inputFloat = (inputPrefix as NSString).floatValue
            multirateDoseSlider4.value = inputFloat
            multirateDoseField4.text = inputPrefix
        }
        updateMultirate()
    }
    
    
    //Periodic Functions
    @IBAction func periodicSliderChanged(_ sender: Any)
    {
        if(!mgMode)
        {
            var doseInt = Int(periodicDoseSlider.value)
            doseInt = doseInt - (doseInt % 5)
            periodicDoseSlider.value = Float(doseInt)
            var doseValue = "\(periodicDoseSlider.value)"
            doseValue = roundValue(inputText: doseValue, roundTo: 1)
            periodicDoseInputField.text = doseValue
        }
        else
        {
            let inputText = "\(periodicDoseSlider.value)"
            let inputPrefix = roundValue(inputText: inputText, roundTo: 1)
            let inputFloat = (inputPrefix as NSString).floatValue
            periodicDoseSlider.value = inputFloat
            periodicDoseInputField.text = inputPrefix
        }
        updatePeriodic()
    }
    @IBAction func periodicDurationChanged(_ sender: Any)
    {
        updatePeriodic()
    }
    
    @IBAction func periodicPeriodStepperChanged(_ sender: Any)
    {
        var cVal = Int(periodicBolusStepper.value)
        if(cVal == 7 && prevStepperVal == 6) { cVal = 8 }
        else if(cVal == 7 && prevStepperVal == 8) { cVal = 6 }
        else if(cVal == 11 && prevStepperVal == 10) { cVal = 12 }
        else if(cVal == 11 && prevStepperVal == 12){ cVal = 10 }
        else if(cVal == 13) { cVal = 15 }
        else if(cVal == 14) { cVal = 12 }
        else if(cVal == 17 && prevStepperVal == 16) { cVal = 18 }
        else if(cVal == 17 && prevStepperVal == 18) { cVal = 16 }
        else if(cVal == 19 && prevStepperVal == 18) { cVal = 20 }
        else if(cVal == 19 && prevStepperVal == 20) { cVal = 18 }
        else if(cVal == 21) { cVal = 24 }
        else if(cVal == 23) { cVal = 20 }
        
        periodicBolusStepper.value = Double(cVal)
        if (cVal == 1)
        {
            periodicBolusNumLabel.text = "\(cVal)" + " Period"
        }
        else
        {
            periodicBolusNumLabel.text = "\(cVal)" + " Periods"
        }
        updatePeriodic()
        prevStepperVal = cVal
    }
    
    
    
    //Constant Functions
    @IBAction func constantSliderChanged(_ sender: Any)
    {
        if(!mgMode)
        {
            var doseInt = Int(constantDoseSlider.value)
            doseInt = doseInt - (doseInt % 5)
            constantDoseSlider.value = Float(doseInt)
            constantDoseInputField.text = "\(constantDoseSlider.value)"
        }
        else
        {
            let inputVal = constantDoseSlider.value
            var inputText = "\(inputVal)"
            inputText = roundValue(inputText: inputText, roundTo: 1)
            let inputFloat = (inputText as NSString).floatValue
            constantDoseSlider.value = inputFloat
            constantDoseInputField.text = inputText
        }
        updateConstant()
    }
    
    
    
    //Master Functions
    lazy var datePicker: UIDatePicker =
        {
            let picker = UIDatePicker()
            picker.datePickerMode = .time
            picker.locale = NSLocale(localeIdentifier: "en_GB") as Locale
            picker.minuteInterval = 15
            return picker
    }()
    
    lazy var dateFormatter: DateFormatter =
        {
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            formatter.dateFormat = "H:mm"
            return formatter
    }()
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        scrollView.setContentOffset(CGPoint(x:0, y:313), animated: true)

        if(textField == multirateStartField1 || textField == multirateStartField2 || textField == multirateStartField3 || textField == multirateStartField4)
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "H:mm"
            let time = formatter.date(from: textField.text!)
            datePicker.date = time!
        }
        else
        {
            disableInputs(currentTextField: textField)
            textHolder = textField.text!
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)
            {
                textField.selectAll(nil)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        activateInputs()
        updateConstant()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
        
        if(textField == constantDoseInputField)
        {
            activateInputs()
            var inputText = textField.text!
            if (inputText == "")
            {
                inputText = textHolder
            }
            var inputFloat = (inputText as NSString).floatValue
            if(inputFloat > constantDoseSlider.maximumValue)
            {
                textField.text = "\(constantDoseSlider.maximumValue)"
                inputFloat = constantDoseSlider.maximumValue
                inputText = textField.text!
            }
            else if(inputFloat < constantDoseSlider.minimumValue)
            {
                textField.text = "\(constantDoseSlider.minimumValue)"
                inputFloat = constantDoseSlider.minimumValue
                inputText = textField.text!
            }
            if(!mgMode)
            {
                var inputInt = Int(inputFloat)
                //inputInt = inputInt - (inputInt % 5)
                constantDoseSlider.value = Float(inputInt)
                let doseInputText = "\(constantDoseSlider.value)"
                textField.text = roundValue(inputText: doseInputText, roundTo: 4)
            }
            else
            {
                let inputPrefix = roundValue(inputText: inputText, roundTo: 4)
                constantDoseInputField.text = inputPrefix
                constantDoseSlider.value = inputFloat
            }
            updateConstant()
        }
        else if(textField == periodicDoseInputField)
        {
            activateInputs()
            var inputText = periodicDoseInputField.text!
            if (inputText == "")
            {
                inputText = textHolder
            }
            var inputFloat = (inputText as NSString).floatValue
            if(inputFloat > periodicDoseSlider.maximumValue)
            {
                periodicDoseInputField.text = "\(periodicDoseSlider.maximumValue)"
                inputFloat = periodicDoseSlider.maximumValue
                inputText = periodicDoseInputField.text!
            }
            else if(inputFloat < periodicDoseSlider.minimumValue)
            {
                periodicDoseInputField.text = "\(periodicDoseSlider.minimumValue)"
                inputFloat = periodicDoseSlider.minimumValue
                inputText = periodicDoseInputField.text!
            }
            if(!mgMode)
            {
                let inputInt = Int(inputFloat)
                //inputInt = inputInt - (inputInt % 5)
                periodicDoseSlider.value = Float(inputInt)
                let doseInputText = "\(periodicDoseSlider.value)"
                periodicDoseInputField.text = roundValue(inputText: doseInputText, roundTo: 4)
            }
            else
            {
                let inputPrefix = roundValue(inputText: inputText, roundTo: 4)
                periodicDoseInputField.text = inputPrefix
                periodicDoseSlider.value = inputFloat
            }
            updatePeriodic()
        }
        else if(textField == multirateDoseField1)
        {
            activateInputs()
            var inputText = multirateDoseField1.text!
            if (inputText == "")
            {
                inputText = textHolder
            }
            var inputFloat = (inputText as NSString).floatValue
            if(inputFloat >  multirateDoseSlider1.maximumValue)
            {
                multirateDoseField1.text = "\(multirateDoseSlider1.maximumValue)"
                inputFloat = multirateDoseSlider1.maximumValue
                inputText = multirateDoseField1.text!
            }
            else if(inputFloat < multirateDoseSlider1.minimumValue)
            {
                multirateDoseField1.text = "\(multirateDoseSlider1.minimumValue)"
                inputFloat = multirateDoseSlider1.minimumValue
                inputText = multirateDoseField1.text!
            }
            if(!mgMode)
            {
                var inputInt = Int(inputFloat)
                //inputInt = inputInt - (inputInt % 5)
                multirateDoseSlider1.value = Float(inputInt)
                let doseInputText = "\(multirateDoseSlider1.value)"
                multirateDoseField1.text = roundValue(inputText: doseInputText, roundTo: 4)
            }
            else
            {
                let inputPrefix = roundValue(inputText: inputText, roundTo: 4)
                multirateDoseField1.text = inputPrefix
                multirateDoseSlider1.value = inputFloat
            }
            updateMultirate()
        }
        else if(textField == multirateDoseField2)
        {
            activateInputs()
            var inputText = multirateDoseField2.text!
            if (inputText == "")
            {
                inputText = textHolder
            }
            var inputFloat = (inputText as NSString).floatValue
            if(inputFloat >  multirateDoseSlider2.maximumValue)
            {
                multirateDoseField2.text = "\(multirateDoseSlider2.maximumValue)"
                inputFloat = multirateDoseSlider2.maximumValue
                inputText = multirateDoseField2.text!
            }
            else if(inputFloat < multirateDoseSlider2.minimumValue)
            {
                multirateDoseField2.text = "\(multirateDoseSlider2.minimumValue)"
                inputFloat = multirateDoseSlider2.minimumValue
                inputText = multirateDoseField2.text!
            }
            if(!mgMode)
            {
                var inputInt = Int(inputFloat)
                //inputInt = inputInt - (inputInt % 5)
                multirateDoseSlider2.value = Float(inputInt)
                let doseInputText = "\(multirateDoseSlider2.value)"
                multirateDoseField2.text = roundValue(inputText: doseInputText, roundTo: 4)
            }
            else
            {
                let inputPrefix = roundValue(inputText: inputText, roundTo: 4)
                multirateDoseField2.text = inputPrefix
                multirateDoseSlider2.value = inputFloat
            }
            updateMultirate()
        }
        else if(textField == multirateDoseField3)
        {
            activateInputs()
            var inputText = multirateDoseField3.text!
            if (inputText == "")
            {
                inputText = textHolder
            }
            var inputFloat = (inputText as NSString).floatValue
            if(inputFloat >  multirateDoseSlider3.maximumValue)
            {
                multirateDoseField3.text = "\(multirateDoseSlider3.maximumValue)"
                inputFloat = multirateDoseSlider3.maximumValue
                inputText = multirateDoseField3.text!
            }
            else if(inputFloat < multirateDoseSlider3.minimumValue)
            {
                multirateDoseField3.text = "\(multirateDoseSlider3.minimumValue)"
                inputFloat = multirateDoseSlider3.minimumValue
                inputText = multirateDoseField3.text!
            }
            if(!mgMode)
            {
                var inputInt = Int(inputFloat)
                //inputInt = inputInt - (inputInt % 5)
                multirateDoseSlider3.value = Float(inputInt)
                let doseInputText = "\(multirateDoseSlider3.value)"
                multirateDoseField3.text = roundValue(inputText: doseInputText, roundTo: 4)
            }
            else
            {
                let inputPrefix = roundValue(inputText: inputText, roundTo: 4)
                multirateDoseField3.text = inputPrefix
                multirateDoseSlider3.value = inputFloat
            }
            updateMultirate()
        }
        else if(textField == multirateDoseField4)
        {
            activateInputs()
            var inputText = multirateDoseField4.text!
            if (inputText == "")
            {
                inputText = textHolder
            }
            var inputFloat = (inputText as NSString).floatValue
            if(inputFloat >  multirateDoseSlider4.maximumValue)
            {
                multirateDoseField4.text = "\(multirateDoseSlider4.maximumValue)"
                inputFloat = multirateDoseSlider4.maximumValue
                inputText = multirateDoseField4.text!
            }
            else if(inputFloat < multirateDoseSlider4.minimumValue)
            {
                multirateDoseField4.text = "\(multirateDoseSlider4.minimumValue)"
                inputFloat = multirateDoseSlider4.minimumValue
                inputText = multirateDoseField4.text!
            }
            if(!mgMode)
            {
                var inputInt = Int(inputFloat)
                //inputInt = inputInt - (inputInt % 5)
                multirateDoseSlider4.value = Float(inputInt)
                let doseInputText = "\(multirateDoseSlider4.value)"
                multirateDoseField4.text = roundValue(inputText: doseInputText, roundTo: 4)
            }
            else
            {
                let inputPrefix = roundValue(inputText: inputText, roundTo: 4)
                multirateDoseField4.text = inputPrefix
                multirateDoseSlider4.value = inputFloat
            }
            updateMultirate()
        }
        else if(textField == masterConcentrationField)
        {
            activateInputs()
            let pumpConText = masterConcentrationField.text!
            let pumpConFloat = (pumpConText as NSString).floatValue
            let dosePerClick = accumVol * pumpConFloat
            let dosePerClickRounded = Double(dosePerClick * 100).rounded() / 100
            dosePerClickField.text = "\(dosePerClickRounded)" + " " + unitLabel
            updateConstant()
            updatePeriodic()
            updateMultirate()
        }
        else
        {
            activateInputs()
            updateConstant()
            updatePeriodic()
            updateMultirate()
        }
    }
    func disableInputs(currentTextField: UITextField)
    {
        
    }
    func activateInputs()
    {
        
    }
    
    @IBAction func masterUnitSwitchChanged(_ sender: Any)
    {
        if(masterUnitSwitch.isOn)
        {
            mgMode = true
            unitLabel = "mg"
            masterConcentrationLabel.text = unitLabel
            constantDoseInputLabel.text = unitLabel
            periodicDoseInputLabel.text = unitLabel
            multirateDoseLabel1.text = unitLabel
            multirateDoseLabel2.text = unitLabel
            multirateDoseLabel3.text = unitLabel
            multirateDoseLabel4.text = unitLabel
            constantDoseSlider.maximumValue = 5
            masterConcentrationField.text = "10.0"
            constantDoseSlider.value = 0.5
            constantDoseInputField.text = "0.5"
            periodicDoseSlider.value = 0.5
            periodicDoseSlider.maximumValue = 5
            periodicDoseInputField.text = "0.5"
            multirateDoseSlider1.maximumValue = 5
            multirateDoseSlider1.value = 0.5
            multirateDoseField1.text = "0.5"
            multirateDoseSlider2.maximumValue = 5
            multirateDoseSlider2.value = 1.0
            multirateDoseField2.text = "1.0"
            multirateDoseSlider3.maximumValue = 5
            multirateDoseSlider3.value = 1.5
            multirateDoseField3.text = "1.5"
            multirateDoseSlider4.maximumValue = 5
            multirateDoseSlider4.value = 2.0
            multirateDoseField4.text = "2.0"
            updateConstant()
            updatePeriodic()
            updateMultirate()
        }
        else
        {
            mgMode = false
            unitLabel = "mcg"
            masterConcentrationLabel.text = unitLabel
            constantDoseInputLabel.text = unitLabel
            periodicDoseInputLabel.text = unitLabel
            multirateDoseLabel1.text = unitLabel
            multirateDoseLabel2.text = unitLabel
            multirateDoseLabel3.text = unitLabel
            multirateDoseLabel4.text = unitLabel
            constantDoseSlider.maximumValue = 300
            masterConcentrationField.text = "350.0"
            constantDoseSlider.value = 10
            constantDoseInputField.text = "10"
            periodicDoseSlider.value = 20
            periodicDoseSlider.maximumValue = 300
            periodicDoseInputField.text = "20"
            multirateDoseSlider1.maximumValue = 200
            multirateDoseSlider1.value = 20
            multirateDoseField1.text = "20"
            multirateDoseSlider2.maximumValue = 200
            multirateDoseSlider2.value = 30
            multirateDoseField2.text = "30"
            multirateDoseSlider3.maximumValue = 200
            multirateDoseSlider3.value = 40
            multirateDoseField3.text = "40"
            multirateDoseSlider4.maximumValue = 200
            multirateDoseSlider4.value = 50
            multirateDoseField4.text = "50"
            updateConstant()
            updatePeriodic()
            updateMultirate()
        }
        let pumpConText = masterConcentrationField.text!
        let pumpConFloat = (pumpConText as NSString).floatValue
        let dosePerClick = accumVol * pumpConFloat
        let dosePerClickRounded = Double(dosePerClick * 100).rounded() / 100
        dosePerClickField.text = "\(dosePerClickRounded)" + " " + unitLabel
    }
    
    func updatePeriodic() -> Void
    {
        let totalDose = Double(periodicDoseSlider.value) * periodicBolusStepper.value
        periodicTotalDoseField.text = "\(totalDose)" + " " + unitLabel
        if(periodicShow)
        {
            genPeriodicGraph()
        }
        else
        {
            self.periodicShapeLayer?.removeFromSuperlayer()
        }
    }
    
    func updateMultirate() -> Void
    {
        var totalDose = Float(0)
        if(Int(multiratePeriodStepper.value) == 2)
        {
            totalDose = multirateDoseSlider1.value + multirateDoseSlider2.value
        }
        else if(Int(multiratePeriodStepper.value) == 3)
        {
            totalDose = multirateDoseSlider1.value + multirateDoseSlider2.value + multirateDoseSlider3.value
        }
        else if(Int(multiratePeriodStepper.value) == 4)
        {
            totalDose = multirateDoseSlider1.value + multirateDoseSlider2.value + multirateDoseSlider3.value + multirateDoseSlider4.value
        }
        multiRateTotalDoseField.text = "\(totalDose)" + " " + unitLabel
        if(multirateShow)
        {
            genMultiRateGraph()
        }
        else
        {
            self.multiRateShapeLayer?.removeFromSuperlayer()
        }
    }
    
    func updateConstant() -> Void
    {
        let inputText = constantDoseInputField.text!
        let inputFloat = (inputText as NSString).floatValue
        let inputPrefix = roundValue(inputText: inputText, roundTo: 4)
        constantDoseSlider.value = inputFloat
        let totalDose = constantDoseSlider.value
        let pumpCon = masterConcentrationField.text!
        let pumpConFloat = (pumpCon as NSString).floatValue
        var timeBetween = String(Float(1440) / ((totalDose / pumpConFloat) / accumVol))
        timeBetween = roundValue(inputText: timeBetween, roundTo: 2)
        if(totalDose == 0)
        {
            constantPumpRateField.text = "0 Valve Actuations"
        }
        else
        {
            constantPumpRateField.text = "1 Valve Actuation every " + timeBetween + " minutes"
        }
        constantTotalDoseField.text = "\(totalDose)" + " " + unitLabel
        if(constantShow)
        {
            genConstantGraph()
        }
        else
        {
            self.constantShapeLayer?.removeFromSuperlayer()
        }
    }
    
    func initializeUI() -> Void
    {
        
    }
    
    func roundValue(inputText: String, roundTo: Int) -> String
    {
        var cap = 0
        let inputFloat = (inputText as NSString).floatValue
        if(inputFloat >= 1000){ cap = 5 + roundTo }
        else if(inputFloat >= 100){ cap = 4 + roundTo }
        else if(inputFloat >= 10){ cap = 3 + roundTo }
        else{ cap = 2 + roundTo }
        return String(inputText.characters.prefix(cap))
    }
    
    func genConstantGraph() -> Void
    {
        //remove old shape layer if any is present
        self.constantShapeLayer?.removeFromSuperlayer()
        let graphX = Float(graphDisplay.frame.origin.x)
        let graphY = Float(graphDisplay.frame.origin.y) - 3
        let graphWidth = Float(graphDisplay.bounds.width)
        let graphHeight = Float(graphDisplay.bounds.height)
        
        //create path for graph to draw
        let path = UIBezierPath()
        var xCoord = Float(0)
        var yCoord = Float(0)
        let totalDose = constantDoseSlider.value
        let pumpCon = masterConcentrationField.text!
        let pumpConFloat = (pumpCon as NSString).floatValue
        var bolNum = Int(((totalDose / pumpConFloat) / accumVol))
        let bolHeight = ((accumVol / Float(1)) * graphHeight) + 8
        let bolSpacing = graphWidth / Float(bolNum)
        bolNum += 1
        
        if(totalDose == 0)
        {
            path.move(to: CGPoint(x: Int(graphX), y: Int(graphHeight + graphY)))
            path.addLine(to: CGPoint(x: Int(graphX + graphWidth), y: Int(graphHeight + graphY)))
        }
        else
        {
            //ok to use cartesian coordinates, will be shifted when assigning points to path
            var coordArray = [[Float]]()
            var c = 0
            var cSet: [Float] = [xCoord, yCoord]
            coordArray.append(cSet)
            
            //points are calculated and added to array
            while (c < bolNum)
            {
                yCoord += bolHeight
                cSet = [xCoord, yCoord]
                coordArray.append(cSet)
                yCoord -= bolHeight
                cSet = [xCoord, yCoord]
                coordArray.append(cSet)
                xCoord += bolSpacing
                if(xCoord > graphWidth)
                {
                    xCoord = graphWidth
                }
                cSet = [xCoord, yCoord]
                coordArray.append(cSet)
                c += 1
            }
            
            /*let scaling = scalePicker.selectedSegmentIndex
            if(scaling == 0)
            {
                //do nothing
            }
            else if(scaling == 1)
            {
                c = 0
                while(c < coordArray.count)
                {
                    coordArray[c][0] = coordArray[c][0] * 4
                    c += 1
                }
            }
            else if(scaling == 2)
            {
                c = 0
                while(c < coordArray.count)
                {
                    coordArray[c][0] = coordArray[c][0] * 48
                    c += 1
                }
            }*/
            
            //add points to path
            c = 1
            path.move(to: CGPoint(x: Int(coordArray[0][0]) + Int(graphX), y: Int(graphHeight + graphY) - Int(coordArray[0][1])))
            while(c < coordArray.count)
            {
                if(Float(coordArray[c][0]) < graphWidth)
                {
                    path.addLine(to: CGPoint(x: Int(coordArray[c][0]) + Int(graphX), y: Int(graphHeight + graphY) - Int(coordArray[c][1])))
                    c += 1
                }
                else
                {
                    path.addLine(to: CGPoint(x: Int(graphWidth) + Int(graphX), y: Int(graphHeight + graphY) - Int(coordArray[c][1])))
                    c = coordArray.count
                }
            }
        }
        
        //create shape layer for that path
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.path = path.cgPath
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineJoin = kCALineJoinRound
        scrollView.layer.addSublayer(shapeLayer)
        
        //save shape layer to viewcontroller
        self.constantShapeLayer = shapeLayer
    }
    
    func genPeriodicGraph() -> Void
    {
        //remove old shape layer if any is present
        self.periodicShapeLayer?.removeFromSuperlayer()
        let graphX = Float(graphDisplay.frame.origin.x)
        let graphY = Float(graphDisplay.frame.origin.y)
        let graphWidth = Float(graphDisplay.bounds.width)
        let graphHeight = Float(graphDisplay.bounds.height)
        let graphX2 = graphX
        let graphY2 = graphY - 3
        
        //create path for graph to draw
        let path = UIBezierPath()
        let path2 = UIBezierPath()
        var xShift = Float(0)
        
        let bolNum = Float(periodicBolusStepper.value)
        let cycWidth = graphWidth / bolNum
        
        var xCoord = Float(0)
        var yCoord = Float(0)
        var yCoord2 = Float(0)
        let components = Calendar.current.dateComponents([.hour, .minute], from: periodicDurationPicker.date)
        let durHour = Float(components.hour!)
        let durMinute = Float(components.minute!)
        let durTotal = (60*durHour) + durMinute
        
        let pumpConText = masterConcentrationField.text!
        let pumpConFloat = (pumpConText as NSString).floatValue
        // let flowRate = bolusRate / pumpConFloat
        // let bolHeight = (bolusRate / maxBolusRate) * graphHeight
        let bolHeight = ((accumVol * pumpConFloat) / yLabelMax) * graphHeight
        let bolWidth = (durTotal / (60*24)) * graphWidth
        let basWidth = cycWidth - bolWidth
        
        let bolPerPeriod = (periodicDoseSlider.value / pumpConFloat) / accumVol
        let distBetweenBol = ((durTotal / bolPerPeriod) / (24*60)) * graphWidth    //in coordinate points

        
        //ok to use cartesian coordinates, will be shifted when assigning points to path
        var coordArray = [[Float]]()
        var coordArray2 = [[Float]]()
        var c = 0
        var bolCounter = 0
        xCoord += xShift
        var cSet: [Float] = [xCoord, yCoord]
        coordArray.append(cSet)
        cSet = [xCoord, yCoord2]
        coordArray2.append(cSet)
        //stores index where beginning of graph is for later swapping
        var zeroIndex = 0
        var zeroIndex2 = 0
        //points are calculated and added to array
        while (c < Int(bolNum))
        {
            bolCounter = 0
            while(bolCounter < Int(bolPerPeriod))
            {
                cSet = [xCoord, yCoord2]
                coordArray2.append(cSet)
                yCoord2 += (accumVol / 0.7) * graphHeight
                yCoord += bolHeight
                cSet = [xCoord, yCoord]
                coordArray.append(cSet)
                cSet = [xCoord, yCoord2]
                coordArray2.append(cSet)
                yCoord -= bolHeight
                cSet = [xCoord, yCoord]
                coordArray.append(cSet)
                xCoord += distBetweenBol
                if (xCoord > graphWidth)
                {
                    cSet = [graphWidth, yCoord]
                    coordArray.append(cSet)
                    cSet = [graphWidth, yCoord2]
                    coordArray2.append(cSet)
                    zeroIndex = coordArray.count
                    zeroIndex2 = coordArray2.count
                    xCoord = xCoord - graphWidth
                    cSet = [0, yCoord]
                    coordArray.append(cSet)
                    cSet = [xCoord, yCoord]
                    coordArray.append(cSet)
                    cSet = [0, yCoord2]
                    coordArray2.append(cSet)
                    cSet = [xCoord, yCoord2]
                    coordArray2.append(cSet)
                }
                else
                {
                    cSet = [xCoord, yCoord]
                    coordArray.append(cSet)
                    cSet = [xCoord, yCoord2]
                    coordArray2.append(cSet)
                }
                bolCounter += 1
            }
            yCoord2 = 0
            cSet = [xCoord, yCoord2]
            coordArray2.append(cSet)
            xCoord += basWidth
            if (xCoord > graphWidth)
            {
                cSet = [graphWidth, yCoord]
                coordArray.append(cSet)
                cSet = [graphWidth, yCoord2]
                coordArray2.append(cSet)
                zeroIndex = coordArray.count
                zeroIndex2 = coordArray2.count
                xCoord = xCoord - graphWidth
                cSet = [0, yCoord]
                coordArray.append(cSet)
                cSet = [xCoord, yCoord]
                coordArray.append(cSet)
                cSet = [0, yCoord2]
                coordArray2.append(cSet)
                cSet = [xCoord, yCoord2]
                coordArray2.append(cSet)
            }
            else
            {
                cSet = [xCoord, yCoord]
                coordArray.append(cSet)
                cSet = [xCoord, yCoord2]
                coordArray2.append(cSet)
            }
            c += 1
        }
        
        
        //if shift is needed, array is shifted
        if(zeroIndex > 0 || zeroIndex2 > 0)
        {
            let endArray = Array(coordArray[0..<zeroIndex])
            let beginArray = Array(coordArray[zeroIndex..<coordArray.count])
            coordArray = beginArray + endArray
            let endArray2 = Array(coordArray2[0..<zeroIndex2])
            let beginArray2 = Array(coordArray2[zeroIndex2..<coordArray2.count])
            coordArray2 = beginArray2 + endArray2
        }
   
        //add points to path
        c = 1
        path.move(to: CGPoint(x: Int(graphX), y: Int(graphHeight + graphY - coordArray[0][1])))
        path2.move(to: CGPoint(x: Int(graphX2), y: Int(graphHeight + graphY2 - coordArray2[0][1])))
        
        while(c < coordArray.count)
        {
            if(coordArray[c][0] <= graphWidth)
            {
                path.addLine(to: CGPoint(x: Int(coordArray[c][0] + graphX), y: Int(graphHeight + graphY - coordArray[c][1])))
                c += 1
            }
            else
            {
                path.addLine(to: CGPoint(x: Int(graphWidth + graphX), y: Int(graphHeight + graphY - coordArray[c][1])))
                c = coordArray.count
            }
        }
        
        c = 1
        while(c < coordArray2.count)
        {
            if(coordArray2[c][0] <= graphWidth)
            {
                path2.addLine(to: CGPoint(x: Int(coordArray2[c][0] + graphX2), y: Int(graphHeight + graphY2 - coordArray2[c][1])))
                c += 1
            }
            else
            {
                path2.addLine(to: CGPoint(x: Int(graphWidth + graphX2), y: Int(graphHeight + graphY2 - coordArray2[c][1])))
                c = coordArray2.count
            }
        }
        
        let shapeLayer2 = CAShapeLayer()
        shapeLayer2.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer2.strokeColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1).cgColor
        shapeLayer2.lineWidth = 3
        shapeLayer2.path = path2.cgPath
        shapeLayer2.lineCap = kCALineCapRound
        shapeLayer2.lineJoin = kCALineJoinRound
        scrollView.layer.addSublayer(shapeLayer2)
        
        //save shape layer to viewcontroller
        self.periodicShapeLayer = shapeLayer2
    }
    
    func genMultiRateGraph() -> Void
    {
        //remove old shape layer if any is present
        self.multiRateShapeLayer?.removeFromSuperlayer()
        
        //create path for graph to draw
        let stepperState = Int(multiratePeriodStepper.value)
        let path = UIBezierPath()
        var xCoord = Float(0)
        var yCoord = Float(0)
        
        //ok to use cartesian coordinates, will be shifted when assigning points to path
        var coordArray = [[Int]]()
        var c = 0
        let pumpConText = masterConcentrationField.text!
        let pumpConFloat = (pumpConText as NSString).floatValue
        
        let graphX = Float(graphDisplay.frame.origin.x)
        let graphY = Float(graphDisplay.frame.origin.y) - 3
        let graphWidth = Float(graphDisplay.bounds.width)
        let graphHeight = Float(graphDisplay.bounds.height)
        
        //stores index where beginning of graph should be for later swapping
        var zeroIndex = 0
        
        //points are calculated and added to array
        xCoord += ((hour1 / 24.00) + (minute1 / (24.00 * 60.00))) * graphWidth
        let maxYValue = multirateDoseSlider1.maximumValue / pumpConFloat
        yCoord = ((multirateDoseSlider1.value / pumpConFloat)) * graphHeight
        var cSet: [Int] = [Int(xCoord), Int(yCoord)]
        coordArray.append(cSet)
        var date1 = multirateStartField1.text
        var date2 = multirateStartField1.text
        var sliderVal = multirateDoseSlider1.value / pumpConFloat
        var prevSliderVal = multirateDoseSlider2.value / pumpConFloat
        while(c < stepperState)
        {
            if(c == 0)
            {
                date1 = multirateStartField1.text
                date2 = multirateStartField2.text
            }
            else if(c == 1)
            {
                date1 = multirateStartField2.text
                date2 = multirateStartField3.text
            }
            else if(c == 2)
            {
                date1 = multirateStartField3.text
                date2 = multirateStartField4.text
            }
            else if(c == 3)
            {
                date1 = multirateStartField4.text
                date2 = multirateStartField1.text
            }
            
            if(stepperState - c == 1)
            {
                sliderVal = multirateDoseSlider1.value / pumpConFloat
                if(stepperState == 2){ prevSliderVal = multirateDoseSlider2.value / pumpConFloat }
                if(stepperState == 3){ prevSliderVal = multirateDoseSlider3.value / pumpConFloat }
                if(stepperState == 4){ prevSliderVal = multirateDoseSlider4.value / pumpConFloat }
                date2 = multirateStartField1.text
            }
            else if(c == 0){ sliderVal = multirateDoseSlider2.value / pumpConFloat }
            else if(c == 1){ sliderVal = multirateDoseSlider3.value / pumpConFloat }
            else if(c == 2){ sliderVal = multirateDoseSlider4.value / pumpConFloat }
            xCoord += calculateXDistance(startTime: date1!, endTime: date2!, gWidth: graphWidth)
            if(xCoord == graphWidth)
            {
                if(sliderVal < prevSliderVal)
                {
                    cSet = [Int(xCoord), Int(yCoord)]
                    coordArray.append(cSet)
                }
                else
                {
                    let xDiff = xCoord - graphWidth
                    xCoord = graphWidth
                    cSet = [Int(xCoord), Int(yCoord)]
                    coordArray.append(cSet)
                    zeroIndex = coordArray.count
                    xCoord = 0
                    cSet = [Int(xCoord), Int(yCoord)]
                    coordArray.append(cSet)
                    xCoord = xDiff
                    cSet = [Int(xCoord), Int(yCoord)]
                    coordArray.append(cSet)
                }
            }
            else if(xCoord > graphWidth)
            {
                
                let xDiff = xCoord - graphWidth
                xCoord = graphWidth
                cSet = [Int(xCoord), Int(yCoord)]
                coordArray.append(cSet)
                zeroIndex = coordArray.count
                xCoord = 0
                cSet = [Int(xCoord), Int(yCoord)]
                coordArray.append(cSet)
                xCoord = xDiff
                cSet = [Int(xCoord), Int(yCoord)]
                coordArray.append(cSet)
                
            }
            else
            {
                cSet = [Int(xCoord), Int(yCoord)]
                coordArray.append(cSet)
            }
            yCoord = (sliderVal) * graphHeight
            cSet = [Int(xCoord), Int(yCoord)]
            coordArray.append(cSet)
            c += 1
        }
        
        //if shift is needed, array is shifted
        if(zeroIndex > 0)
        {
            let endArray = Array(coordArray[0..<zeroIndex])
            let beginArray = Array(coordArray[zeroIndex..<coordArray.count])
            coordArray = beginArray + endArray
        }
        //add points to path
        c = 1
        path.move(to: CGPoint(x: coordArray[0][0] + Int(graphX), y: Int(graphHeight + graphY) - coordArray[0][1]))
        while(c < coordArray.count)
        {
            path.addLine(to: CGPoint(x: coordArray[c][0] + Int(graphX), y: Int(graphHeight + graphY) - coordArray[c][1]))
            c += 1
        }
        
        //create shape layer for that path
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.path = path.cgPath
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineJoin = kCALineJoinRound
        scrollView.layer.addSublayer(shapeLayer)
        
        //save shape layer to viewcontroller
        self.multiRateShapeLayer = shapeLayer
    }
    
    func calculateXDistance(startTime: String, endTime: String, gWidth: Float) -> Float
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm"
        let startTime2 = formatter.date(from: startTime)
        let endTime2 = formatter.date(from: endTime)
        var components = Calendar.current.dateComponents([.hour, .minute], from: startTime2!)
        let sTime = (Float(components.hour!) / 24.00) + (Float(components.minute!) / (24.00 * 60.00))
        components = Calendar.current.dateComponents([.hour, .minute], from: endTime2!)
        let eTime = (Float(components.hour!) / 24.00) + (Float(components.minute!) / (24.00 * 60.00))
        let xDist = ((eTime - sTime) * (gWidth))
        if(xDist < 0){return (gWidth + xDist)}
        return xDist
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        NKInputView.with(constantDoseInputField, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(multirateDoseField1, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(multirateDoseField2, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(multirateDoseField3, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(multirateDoseField4, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(periodicDoseInputField, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(masterConcentrationField, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        
        multirateStartField1.inputView = datePicker
        let toolBar1 = UIToolbar().ToolbarPicker(mySelect: #selector(View_MultipleRates.dismissPicker1))
        multirateStartField1.inputAccessoryView = toolBar1
        
        multirateStartField2.inputView = datePicker
        let toolBar2 = UIToolbar().ToolbarPicker(mySelect: #selector(View_MultipleRates.dismissPicker2))
        multirateStartField2.inputAccessoryView = toolBar2
        
        multirateStartField3.inputView = datePicker
        let toolBar3 = UIToolbar().ToolbarPicker(mySelect: #selector(View_MultipleRates.dismissPicker3))
        multirateStartField3.inputAccessoryView = toolBar3
        
        multirateStartField4.inputView = datePicker
        let toolBar4 = UIToolbar().ToolbarPicker(mySelect: #selector(View_MultipleRates.dismissPicker4))
        multirateStartField4.inputAccessoryView = toolBar4
        
        let date = Date()
        let calendar = Calendar.current
        startHour = Float(calendar.component(.hour, from: date))
        startMinute = Float(calendar.component(.minute, from: date))
        multirateControlStack3.isUserInteractionEnabled = false
        multirateControlStack4.isUserInteractionEnabled = false
        multirateStartField1.text = "00:00"
        hour1 = 0
        minute1 = 0
        multirateStartField2.text = "12:00"
        hour2 = 12
        minute2 = 0
        self.multirateControlStack3.alpha = 0.0
        self.multirateControlStack4.alpha = 0.0
        
        let pumpConText = masterConcentrationField.text!
        let pumpConFloat = (pumpConText as NSString).floatValue
        let dosePerClick = accumVol * pumpConFloat
        let dosePerClickRounded = Double(dosePerClick * 100).rounded() / 100
        dosePerClickField.text = "\(dosePerClickRounded)" + " " + unitLabel
        
        updateConstant()
        updatePeriodic()
        updateMultirate()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
