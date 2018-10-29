//
//  View_MultipleRates.swift
//  IntrathecalTherapyOptimization
//
//  Created by Jullian Cockerell on 8/1/18.
//  Copyright © 2018 RedRoosterDevelopment. All rights reserved.
//

import UIKit

class View_MultipleRates: UIViewController, UITextFieldDelegate {

    var globalYMargin = Float(55)
    var mgMode = true
    var unitLabel = "mg"
    var yScale = Float(7.0)
    var accumVol = Float(0.0025)
    var textHolder = ""
    var pumpVolume = Float(20)
    var maxYScaleb = Float(10)
    
    // Defaults: Dose, Concentration, Accumulator Volume, Maximum Dose, Y Scale, Pump Volume
    // index 0 for mg, index 1 for mcg
    let defAccumVol = Float(0.0025)
    let defDoseMg = [Float(0.5), Float(1.0), Float(1.5), Float(2.0)]
    let defDoseMcg = [Float(20.0), Float(30.0), Float(40.0), Float(50.0)]
    let defConcentration = [Float(20.0), Float(350.0)]
    let defDoseMax = [Float(5), Float(100)]
    let defYScale = [Float(7.0), Float(300.0)]
    let defPumpVolume = Float(20)
    
    var hour1 = Float(0)
    var hour2 = Float(0)
    var hour3 = Float(0)
    var hour4 = Float(0)
    var minute1 = Float(0)
    var minute2 = Float(0)
    var minute3 = Float(0)
    var minute4 = Float(0)
    
    
    @IBOutlet weak var periodStepper: UIStepper!
    @IBOutlet weak var periodStepperLabel: UILabel!
    @IBOutlet weak var doseSlider1: UISlider!
    @IBOutlet weak var doseSlider2: UISlider!
    @IBOutlet weak var doseSlider3: UISlider!
    @IBOutlet weak var doseSlider4: UISlider!
    @IBOutlet weak var graphImage: UIImageView!
    @IBOutlet weak var warningImage: UIImageView!
    @IBOutlet weak var controlStack1: UIStackView!
    @IBOutlet weak var controlStack2: UIStackView!
    @IBOutlet weak var controlStack4: UIStackView!
    @IBOutlet weak var controlStack3: UIStackView!
    @IBOutlet weak var rate1: UITextField!
    @IBOutlet weak var rate2: UITextField!
    @IBOutlet weak var rate3: UITextField!
    @IBOutlet weak var rate4: UITextField!
    @IBOutlet weak var doseInput1: AllowedCharsTextField!
    @IBOutlet weak var doseInput2: AllowedCharsTextField!
    @IBOutlet weak var doseInput3: AllowedCharsTextField!
    @IBOutlet weak var doseInput4: AllowedCharsTextField!
    @IBOutlet weak var totalDoseField: UITextField!
    @IBOutlet weak var concentrationField: AllowedCharsTextField!
    @IBOutlet weak var concentrationFieldLabel: UILabel!
    @IBOutlet weak var doseLabel1: UILabel!
    @IBOutlet weak var doseLabel2: UILabel!
    @IBOutlet weak var doseLabel3: UILabel!
    @IBOutlet weak var doseLabel4: UILabel!
    @IBOutlet weak var controlBorder: UIView!
    @IBOutlet weak var graphBorder: UIView!
    @IBOutlet weak var graphBorder2: UIView!
    @IBOutlet weak var miscBorder: UIView!
    @IBOutlet weak var controlBorderHeight: NSLayoutConstraint!
    @IBOutlet weak var miscStackTopDistance: NSLayoutConstraint!
    @IBOutlet weak var yScale1: UILabel!
    @IBOutlet weak var yScale2: UILabel!
    @IBOutlet weak var yScale3: UILabel!
    @IBOutlet weak var yScale4: UILabel!
    @IBOutlet weak var yScale5: UILabel!
    @IBOutlet weak var topGraph: UIImageView!
    @IBOutlet weak var bottomGraph: UIImageView!
    @IBOutlet weak var unitSwitch: UISwitch!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    
    // Advanced Settings
    @IBOutlet weak var advancedSettingsView: UIView!
    @IBOutlet weak var advancedSettingsOpenButton: UIButton!
    @IBOutlet weak var advancedSettingsCloseButton: UIButton!
    @IBOutlet weak var accumulatorVolumeField: AllowedCharsTextField!
    @IBOutlet weak var pumpVolumeField: AllowedCharsTextField!
    @IBOutlet weak var daysUntilRefillField: AllowedCharsTextField!
    @IBOutlet weak var advancedSettingsConstraint: NSLayoutConstraint!
    
    //Y-Axis Labels
    //Bottom
    @IBOutlet weak var yScaleb1: UILabel!
    @IBOutlet weak var yScaleb2: UILabel!
    @IBOutlet weak var yScaleb3: UILabel!
    @IBOutlet weak var yScaleb4: UILabel!
    @IBOutlet weak var yScaleb5: UILabel!
    //Top
    @IBOutlet weak var yScalet1: UILabel!
    @IBOutlet weak var yScalet2: UILabel!
    @IBOutlet weak var yScalet3: UILabel!
    @IBOutlet weak var yScalet4: UILabel!
    @IBOutlet weak var yScalet5: UILabel!
    
    //Time Labels
    @IBOutlet weak var label24_1: UILabel!
    @IBOutlet weak var label24_2: UILabel!
    @IBOutlet weak var label24_3: UILabel!
    @IBOutlet weak var label24_4: UILabel!
    @IBOutlet weak var label6_1: UILabel!
    @IBOutlet weak var label6_2: UILabel!
    @IBOutlet weak var label6_3: UILabel!
    @IBOutlet weak var label6_4: UILabel!
    @IBOutlet weak var label30_1: UILabel!
    @IBOutlet weak var label30_2: UILabel!

    @IBOutlet weak var yAxisTopLabel: UILabel!
    @IBOutlet weak var yAxisBottomLabel: UILabel!
    
    //Time Inputs
    @IBOutlet weak var timeInput1: UITextField!
    @IBOutlet weak var timeInput2: UITextField!
    @IBOutlet weak var timeInput3: UITextField!
    @IBOutlet weak var timeInput4: UITextField!
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        scrollView.setContentOffset(CGPoint(x:0, y:313), animated: true)
        if(textField == timeInput1 || textField == timeInput2 || textField == timeInput3 || textField == timeInput4)
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
        updateUI()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
        if(textField == accumulatorVolumeField)
        {
            activateInputs()
            if(accumulatorVolumeField.text == "")
            {
                accumulatorVolumeField.text = textHolder
            }
            let accumulatorVolumeText = accumulatorVolumeField.text!
            accumVol = (accumulatorVolumeText as NSString).floatValue
            updateUI()
        }
        else if(textField == pumpVolumeField)
        {
            activateInputs()
            if(pumpVolumeField.text == "")
            {
                pumpVolumeField.text = textHolder
            }
            let pumpVolumeText = pumpVolumeField.text!
            pumpVolume = (pumpVolumeText as NSString).floatValue
            updateUI()
        }
        else if(textField == doseInput1)
        {
            activateInputs()
            var inputText = doseInput1.text!
            if (inputText == "")
            {
                inputText = textHolder
            }
            var inputFloat = (inputText as NSString).floatValue
            if(inputFloat > doseSlider1.maximumValue)
            {
                doseInput1.text = "\(doseSlider1.maximumValue)"
                inputFloat = doseSlider1.maximumValue
                inputText = doseInput1.text!
            }
            else if(inputFloat < doseSlider1.minimumValue)
            {
                doseInput1.text = "\(doseSlider1.minimumValue)"
                inputFloat = doseSlider1.minimumValue
                inputText = doseInput1.text!
            }
            if(!mgMode)
            {
                var inputInt = Int(inputFloat)
                //inputInt = inputInt - (inputInt % 5)
                doseSlider1.value = Float(inputInt)
                let doseInputText = "\(doseSlider1.value)"
                doseInput1.text = roundValue(inputText: doseInputText, roundTo: 4)
            }
            else
            {
                let inputPrefix = roundValue(inputText: inputText, roundTo: 4)
                doseInput1.text = inputPrefix
                doseSlider1.value = inputFloat
            }
            updateUI()
        }
        else if(textField == doseInput2)
        {
            activateInputs()
            var inputText = doseInput2.text!
            if (inputText == "")
            {
                inputText = textHolder
            }
            
            var inputFloat = (inputText as NSString).floatValue
            if(inputFloat > doseSlider2.maximumValue)
            {
                doseInput2.text = "\(doseSlider2.maximumValue)"
                inputFloat = doseSlider2.maximumValue
                inputText = doseInput2.text!
            }
            else if(inputFloat < doseSlider2.minimumValue)
            {
                doseInput2.text = "\(doseSlider2.minimumValue)"
                inputFloat = doseSlider2.minimumValue
                inputText = doseInput2.text!
            }
            if(!mgMode)
            {
                var inputInt = Int(inputFloat)
                //inputInt = inputInt - (inputInt % 5)
                doseSlider2.value = Float(inputInt)
                let doseInputText = "\(doseSlider2.value)"
                doseInput2.text = roundValue(inputText: doseInputText, roundTo: 4)
            }
            else
            {
                let inputPrefix = roundValue(inputText: inputText, roundTo: 4)
                doseInput2.text = inputPrefix
                doseSlider2.value = inputFloat
            }
            updateUI()
        }
        else if(textField == doseInput3)
        {
            activateInputs()
            var inputText = doseInput3.text!
            if (inputText == "")
            {
                inputText = textHolder
            }
            var inputFloat = (inputText as NSString).floatValue
            if(inputFloat > doseSlider3.maximumValue)
            {
                doseInput3.text = "\(doseSlider3.maximumValue)"
                inputFloat = doseSlider3.maximumValue
                inputText = doseInput3.text!
            }
            else if(inputFloat < doseSlider3.minimumValue)
            {
                doseInput3.text = "\(doseSlider3.minimumValue)"
                inputFloat = doseSlider3.minimumValue
                inputText = doseInput3.text!
            }
            if(!mgMode)
            {
                var inputInt = Int(inputFloat)
                //inputInt = inputInt - (inputInt % 5)
                doseSlider3.value = Float(inputInt)
                let doseInputText = "\(doseSlider3.value)"
                doseInput3.text = roundValue(inputText: doseInputText, roundTo: 4)
            }
            else
            {
                let inputPrefix = roundValue(inputText: inputText, roundTo: 4)
                doseInput3.text = inputPrefix
                doseSlider3.value = inputFloat
            }
            updateUI()
        }
        else if(textField == doseInput4)
        {
            activateInputs()
            var inputText = doseInput4.text!
            if (inputText == "")
            {
                inputText = textHolder
            }
            var inputFloat = (inputText as NSString).floatValue
            if(inputFloat > doseSlider4.maximumValue)
            {
                doseInput1.text = "\(doseSlider4.maximumValue)"
                inputFloat = doseSlider4.maximumValue
                inputText = doseInput4.text!
            }
            else if(inputFloat < doseSlider4.minimumValue)
            {
                doseInput1.text = "\(doseSlider4.minimumValue)"
                inputFloat = doseSlider4.minimumValue
                inputText = doseInput4.text!
            }
            if(!mgMode)
            {
                var inputInt = Int(inputFloat)
                //inputInt = inputInt - (inputInt % 5)
                doseSlider4.value = Float(inputInt)
                let doseInputText = "\(doseSlider4.value)"
                doseInput4.text = roundValue(inputText: doseInputText, roundTo: 4)
            }
            else
            {
                let inputPrefix = roundValue(inputText: inputText, roundTo: 4)
                doseInput4.text = inputPrefix
                doseSlider4.value = inputFloat
            }
            updateUI()
        }
        
    }
    

    @IBAction func startPicker1Changed(_ sender: UIDatePicker)
    {
        if(isValid())
        {
            updateUI()
        }
        
    }
    
    @IBAction func startPicker2Changed(_ sender: UIDatePicker)
    {
        if(isValid())
        {
            updateUI()
        }
    }
    
    @IBAction func startPicker3Changed(_ sender: UIDatePicker)
    {
        if(isValid())
        {
            updateUI()
        }
    }
    
    @IBAction func startPicker4Changed(_ sender: UIDatePicker)
    {
        if(isValid())
        {
            updateUI()
        }
    }
    
    
    
    
    @IBAction func slider2Changed(_ sender: UISlider)
    {
        if(!mgMode)
        {
            var doseInt = Int(doseSlider2.value)
            doseInt = doseInt - (doseInt % 5)
            doseSlider2.value = Float(doseInt)
            var doseValue = "\(doseSlider2.value)"
            doseValue = roundValue(inputText: doseValue, roundTo: 1)
            doseInput2.text = doseValue
        }
        else
        {
            let inputText = "\(doseSlider2.value)"
            let inputPrefix = roundValue(inputText: inputText, roundTo: 1)
            let inputFloat = (inputPrefix as NSString).floatValue
            doseSlider2.value = inputFloat
            doseInput2.text = inputPrefix
        }
        updateUI()
    }
    
    @IBAction func slider3Changed(_ sender: UISlider)
    {
        if(!mgMode)
        {
            var doseInt = Int(doseSlider3.value)
            doseInt = doseInt - (doseInt % 5)
            doseSlider3.value = Float(doseInt)
            var doseValue = "\(doseSlider3.value)"
            doseValue = roundValue(inputText: doseValue, roundTo: 1)
            doseInput3.text = doseValue
        }
        else
        {
            let inputText = "\(doseSlider3.value)"
            let inputPrefix = roundValue(inputText: inputText, roundTo: 1)
            let inputFloat = (inputPrefix as NSString).floatValue
            doseSlider3.value = inputFloat
            doseInput3.text = inputPrefix
        }
        updateUI()
    }
    
    @IBAction func slider4Changed(_ sender: UISlider)
    {
        if(!mgMode)
        {
            var doseInt = Int(doseSlider4.value)
            doseInt = doseInt - (doseInt % 5)
            doseSlider4.value = Float(doseInt)
            var doseValue = "\(doseSlider4.value)"
            doseValue = roundValue(inputText: doseValue, roundTo: 1)
            doseInput4.text = doseValue
        }
        else
        {
            let inputText = "\(doseSlider4.value)"
            let inputPrefix = roundValue(inputText: inputText, roundTo: 1)
            let inputFloat = (inputPrefix as NSString).floatValue
            doseSlider4.value = inputFloat
            doseInput4.text = inputPrefix
        }
        updateUI()
    }
    
    @IBAction func slider1Changed(_ sender: UISlider)
    {
        if(!mgMode)
        {
            var doseInt = Int(doseSlider1.value)
            doseInt = doseInt - (doseInt % 5)
            doseSlider1.value = Float(doseInt)
            var doseValue = "\(doseSlider1.value)"
            doseValue = roundValue(inputText: doseValue, roundTo: 1)
            doseInput1.text = doseValue
        }
        else
        {
            let inputText = "\(doseSlider1.value)"
            let inputPrefix = roundValue(inputText: inputText, roundTo: 1)
            let inputFloat = (inputPrefix as NSString).floatValue
            doseSlider1.value = inputFloat
            doseInput1.text = inputPrefix
        }
        updateUI()
    }
   
    
    @IBAction func advancedSettingsClose(_ sender: UIButton)
    {
        advancedSettingsConstraint.constant = 540
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations:
        {
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func advancedSettingsOpen(_ sender: UIButton)
    {
        advancedSettingsConstraint.constant = 20
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations:
        {
            self.view.layoutIfNeeded()
        })
    }
    
    
    
    
    
    
    
    func dismissPicker1()
    {
        activateInputs()
        view.endEditing(true)
        let components = Calendar.current.dateComponents([.hour, .minute], from: datePicker.date)
        hour1 = Float(components.hour!)
        minute1 = Float(components.minute!)
        timeInput1.text = dateFormatter.string(from: datePicker.date)
        updateUI()
    }
    
    func dismissPicker2()
    {
        activateInputs()
        view.endEditing(true)
        let components = Calendar.current.dateComponents([.hour, .minute], from: datePicker.date)
        hour2 = Float(components.hour!)
        minute2 = Float(components.minute!)
        timeInput2.text = dateFormatter.string(from: datePicker.date)
        updateUI()
    }
    
    func dismissPicker3()
    {
        activateInputs()
        view.endEditing(true)
        let components = Calendar.current.dateComponents([.hour, .minute], from: datePicker.date)
        hour3 = Float(components.hour!)
        minute3 = Float(components.minute!)
        timeInput3.text = dateFormatter.string(from: datePicker.date)
        updateUI()
    }
    
    func dismissPicker4()
    {
        activateInputs()
        view.endEditing(true)
        let components = Calendar.current.dateComponents([.hour, .minute], from: datePicker.date)
        hour4 = Float(components.hour!)
        minute4 = Float(components.minute!)
        timeInput4.text = dateFormatter.string(from: datePicker.date)
        updateUI()
    }
    
    
    
    func disableInputs(currentTextField: UITextField) -> Void
    {
        periodStepper.isUserInteractionEnabled = false
        doseSlider1.isUserInteractionEnabled = false
        doseSlider2.isUserInteractionEnabled = false
        doseSlider3.isUserInteractionEnabled = false
        doseSlider4.isUserInteractionEnabled = false
        timeInput1.isUserInteractionEnabled = false
        timeInput2.isUserInteractionEnabled = false
        timeInput3.isUserInteractionEnabled = false
        timeInput4.isUserInteractionEnabled = false
        unitSwitch.isUserInteractionEnabled = false
        advancedSettingsOpenButton.isUserInteractionEnabled = false
        advancedSettingsCloseButton.isUserInteractionEnabled = false
        if(currentTextField != accumulatorVolumeField){ accumulatorVolumeField.isUserInteractionEnabled = false }
        if(currentTextField != pumpVolumeField){ pumpVolumeField.isUserInteractionEnabled = false }
        if(currentTextField != doseInput1){ doseInput1.isUserInteractionEnabled = false }
        if(currentTextField != doseInput2){ doseInput2.isUserInteractionEnabled = false }
        if(currentTextField != doseInput3){ doseInput3.isUserInteractionEnabled = false }
        if(currentTextField != doseInput4){ doseInput4.isUserInteractionEnabled = false }
        if(currentTextField != concentrationField){ concentrationField.isUserInteractionEnabled = false }
    }
    
    func activateInputs() -> Void
    {
        periodStepper.isUserInteractionEnabled = true
        doseSlider1.isUserInteractionEnabled = true
        doseSlider2.isUserInteractionEnabled = true
        doseSlider3.isUserInteractionEnabled = true
        doseSlider4.isUserInteractionEnabled = true
        timeInput1.isUserInteractionEnabled = true
        timeInput2.isUserInteractionEnabled = true
        timeInput3.isUserInteractionEnabled = true
        timeInput4.isUserInteractionEnabled = true
        unitSwitch.isUserInteractionEnabled = true
        doseInput1.isUserInteractionEnabled = true
        doseInput2.isUserInteractionEnabled = true
        doseInput3.isUserInteractionEnabled = true
        doseInput4.isUserInteractionEnabled = true
        concentrationField.isUserInteractionEnabled = true
        advancedSettingsCloseButton.isUserInteractionEnabled = true
        advancedSettingsOpenButton.isUserInteractionEnabled = true
        accumulatorVolumeField.isUserInteractionEnabled = true
        pumpVolumeField.isUserInteractionEnabled = true
    }
    
    
    
    
 
    @IBAction func unitSwitchChanged(_ sender: UISwitch)
    {
        if(mgMode)
        {
            unitLabel = "mcg"
            yScale = defYScale[1]
            mgMode = false
            doseSlider1.maximumValue = defDoseMax[1]
            doseSlider1.value = defDoseMcg[0]
            concentrationField.text = "\(defConcentration[1])"
            doseInput1.text = "\(defDoseMcg[0])"
            doseSlider2.maximumValue = defDoseMax[1]
            doseSlider2.value = defDoseMcg[1]
            doseInput2.text = "\(defDoseMcg[1])"
            doseSlider3.maximumValue = defDoseMax[1]
            doseSlider3.value = defDoseMcg[2]
            doseInput3.text = "\(defDoseMcg[2])"
            doseSlider4.maximumValue = defDoseMax[1]
            doseSlider4.value = defDoseMcg[3]
            doseInput4.text = "\(defDoseMcg[3])"
            yScaleb1.text = "0.5"
            yScaleb2.text = "1.0"
            yScaleb3.text = "1.5"
            yScaleb4.text = "2.0"
            yScaleb5.text = "2.5"
            yScalet1.text = "20.0"
            yScalet2.text = "40.0"
            yScalet3.text = "60.0"
            yScalet4.text = "80.0"
            yScalet5.text = "100.0"
            yAxisTopLabel.text = "  Period Dose (mcg)"
            yAxisBottomLabel.text = "  Dose (mcg)"
            maxYScaleb = Float(2.5)
        }
        else if(!mgMode)
        {
            unitLabel = "mg"
            yScale = defYScale[0]
            mgMode = true
            doseSlider1.maximumValue = defDoseMax[0]
            doseSlider1.value = defDoseMg[0]
            concentrationField.text = "\(defConcentration[0])"
            doseInput1.text = "\(defDoseMg[0])"
            doseSlider2.maximumValue = defDoseMax[0]
            doseSlider2.value = defDoseMg[1]
            doseInput2.text = "\(defDoseMg[1])"
            doseSlider3.maximumValue = defDoseMax[0]
            doseSlider3.value = defDoseMg[2]
            doseInput3.text = "\(defDoseMg[2])"
            doseSlider4.maximumValue = defDoseMax[0]
            doseSlider4.value = defDoseMg[3]
            doseInput4.text = "\(defDoseMg[3])"
            yScaleb1.text = "0.02"
            yScaleb2.text = "0.04"
            yScaleb3.text = "0.06"
            yScaleb4.text = "0.08"
            yScaleb5.text = "0.1"
            yScalet1.text = "1.0"
            yScalet2.text = "2.0"
            yScalet3.text = "3.0"
            yScalet4.text = "4.0"
            yScalet5.text = "5.0"
            yAxisTopLabel.text = "  Period Dose (mg)"
            yAxisBottomLabel.text = "  Dose (mg)"
            maxYScaleb = Float(0.1)
        }
        updateUI()
    }
    
    func setYScaleLabels() -> Void
    {
        let maxRate = doseSlider1.maximumValue
        let maxRateInterval = (maxRate / 5)
        var roundNumber = 2
        if(mgMode)
        {
            roundNumber = 2
        }
        else
        {
            roundNumber = 1
        }
        yScale1.text = roundValue(inputText: "\(maxRateInterval)", roundTo: roundNumber)
        yScale2.text = roundValue(inputText: "\(maxRateInterval * 2)", roundTo: roundNumber)
        yScale3.text = roundValue(inputText: "\(maxRateInterval * 3)", roundTo: roundNumber)
        yScale4.text = roundValue(inputText: "\(maxRateInterval * 4)", roundTo: roundNumber)
        yScale5.text = roundValue(inputText: "\(maxRateInterval * 5)", roundTo: roundNumber)
    }
    
    
    weak var shapeLayer: CAShapeLayer?
    weak var shapeLayer2: CAShapeLayer?
    
    @IBAction func periodStepperChanged(_ sender: UIStepper)
    {
        let stepperState = Int(sender.value)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        var dateVar = formatter.date(from: "00:00")
        periodStepperLabel.text = "\(stepperState)"
        
        if(stepperState == 2)
        {
            controlStack2.isUserInteractionEnabled = true
            controlStack3.isUserInteractionEnabled = false
            controlStack4.isUserInteractionEnabled = false
            timeInput1.text = "00:00"
            hour1 = 0
            minute1 = 0
            timeInput2.text = "12:00"
            hour2 = 12
            minute2 = 0
            self.controlBorderHeight.constant = 135
            UIView.animate(withDuration: 0.5, animations:
            {
                self.view.layoutIfNeeded()
                self.controlStack2.alpha = 1.0
                self.controlStack3.alpha = 0.0
                self.controlStack4.alpha = 0.0
            })
        }
        else if(stepperState == 3)
        {
            controlStack2.isUserInteractionEnabled = true
            controlStack3.isUserInteractionEnabled = true
            controlStack4.isUserInteractionEnabled = false
            timeInput1.text = "00:00"
            hour1 = 0
            minute1 = 0
            timeInput2.text = "8:00"
            hour2 = 8
            minute2 = 0
            timeInput3.text = "16:00"
            hour3 = 16
            minute3 = 0
            self.controlBorderHeight.constant = 205
            UIView.animate(withDuration: 0.6, animations:
            {
                self.view.layoutIfNeeded()
                self.controlStack2.alpha = 1.0
                self.controlStack3.alpha = 1.0
                self.controlStack4.alpha = 0.0
            })
        }
        else if(stepperState == 4)
        {
            controlStack2.isUserInteractionEnabled = true
            controlStack3.isUserInteractionEnabled = true
            controlStack4.isUserInteractionEnabled = true
            timeInput1.text = "00:00"
            hour1 = 0
            minute1 = 0
            timeInput2.text = "6:00"
            hour2 = 6
            minute2 = 0
            timeInput3.text = "12:00"
            hour3 = 12
            minute3 = 0
            timeInput4.text = "18:00"
            hour4 = 18
            minute4 = 0
            self.controlBorderHeight.constant = 275
            UIView.animate(withDuration: 0.5, animations:
            {
                self.view.layoutIfNeeded()
                self.controlStack2.alpha = 1.0
                self.controlStack3.alpha = 1.0
                self.controlStack4.alpha = 1.0
            })
        }
        updateUI()
    }
    
    func isValid() -> Bool
    {
        var durTotal = Float(0)
        let stepperState = Int(periodStepper.value)
        if(stepperState == 2)
        {
            durTotal = calculateXDistance(startTime: timeInput1.text!, endTime: timeInput2.text!, gWidth: 100.00) + calculateXDistance(startTime: timeInput2.text!, endTime: timeInput1.text!, gWidth: 100.00)
        }
        else if (stepperState == 3)
        {
            durTotal = calculateXDistance(startTime: timeInput1.text!, endTime: timeInput2.text!, gWidth: 100.00) + calculateXDistance(startTime: timeInput2.text!, endTime: timeInput3.text!, gWidth: 100.00) + calculateXDistance(startTime: timeInput3.text!, endTime: timeInput1.text!, gWidth: 100.00)
        }
        else if (stepperState == 4)
        {
            durTotal = calculateXDistance(startTime: timeInput1.text!, endTime: timeInput2.text!, gWidth: 100.00) + calculateXDistance(startTime: timeInput2.text!, endTime: timeInput3.text!, gWidth: 100.00) + calculateXDistance(startTime: timeInput3.text!, endTime: timeInput4.text!, gWidth: 100.00) + calculateXDistance(startTime: timeInput4.text!, endTime: timeInput1.text!, gWidth: 100.00)
        }
        if(durTotal > 100.00)
        {
            warningImage.alpha = 1.0
            self.shapeLayer?.removeFromSuperlayer()
        }
        else{warningImage.alpha = 0.0}
        return (durTotal <= 100.00)
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
    
    
    @IBAction func concentrationFieldChanged(_ sender: AllowedCharsTextField)
    {
        activateInputs()
        if (concentrationField.text == "")
        {
            concentrationField.text = textHolder
        }
        updateUI()
    }
    
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
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NKInputView.with(doseInput1, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(doseInput2, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(doseInput3, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(doseInput4, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(concentrationField, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(pumpVolumeField, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(accumulatorVolumeField, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        
        timeInput1.inputView = datePicker
        let toolBar1 = UIToolbar().ToolbarPicker(mySelect: #selector(View_MultipleRates.dismissPicker1))
        timeInput1.inputAccessoryView = toolBar1
        
        timeInput2.inputView = datePicker
        let toolBar2 = UIToolbar().ToolbarPicker(mySelect: #selector(View_MultipleRates.dismissPicker2))
        timeInput2.inputAccessoryView = toolBar2
        
        timeInput3.inputView = datePicker
        let toolBar3 = UIToolbar().ToolbarPicker(mySelect: #selector(View_MultipleRates.dismissPicker3))
        timeInput3.inputAccessoryView = toolBar3
        
        timeInput4.inputView = datePicker
        let toolBar4 = UIToolbar().ToolbarPicker(mySelect: #selector(View_MultipleRates.dismissPicker4))
        timeInput4.inputAccessoryView = toolBar4
        
        miscStackTopDistance.constant = 30
        controlStack3.alpha = 0.0
        controlStack4.alpha = 0.0
        
        self.advancedSettingsView.layer.borderWidth = 2
        self.advancedSettingsView.layer.cornerRadius = 10
        self.advancedSettingsView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.graphBorder.layer.borderWidth = 2
        self.graphBorder.layer.cornerRadius = 10
        self.graphBorder.layer.borderColor = UIColor.lightGray.cgColor
        self.graphBorder2.layer.borderWidth = 2
        self.graphBorder2.layer.cornerRadius = 10
        self.graphBorder2.layer.borderColor = UIColor.lightGray.cgColor
        self.controlBorder.layer.borderWidth = 2
        self.controlBorder.layer.cornerRadius = 10
        self.controlBorder.layer.borderColor = UIColor.lightGray.cgColor
        self.miscBorder.layer.borderWidth = 2
        self.miscBorder.layer.cornerRadius = 10
        self.miscBorder.layer.borderColor = UIColor.lightGray.cgColor
        
        self.advancedSettingsOpenButton.layer.borderColor = UIColor.lightGray.cgColor
        self.advancedSettingsOpenButton.layer.borderWidth = 2
        self.advancedSettingsOpenButton.layer.cornerRadius = 5
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1
        paragraphStyle.lineHeightMultiple = 0.7
        
        var attrString = NSMutableAttributedString(string: "12\nAM")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        label24_1.attributedText = attrString
        
        attrString = NSMutableAttributedString(string: "6\nAM")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        label24_2.attributedText = attrString
        
        attrString = NSMutableAttributedString(string: "12\nPM")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        label24_3.attributedText = attrString
        
        attrString = NSMutableAttributedString(string: "6\nPM")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        label24_4.attributedText = attrString
        
        attrString = NSMutableAttributedString(string: "12\nAM")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        label6_1.attributedText = attrString
        
        attrString = NSMutableAttributedString(string: "1:30\nAM")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        label6_2.attributedText = attrString
        
        attrString = NSMutableAttributedString(string: "3\nAM")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        label6_3.attributedText = attrString
        
        attrString = NSMutableAttributedString(string: "4:30\nAM")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        label6_4.attributedText = attrString
        
        attrString = NSMutableAttributedString(string: "12\nAM")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        label30_1.attributedText = attrString
        
        attrString = NSMutableAttributedString(string: "12:15\nAM")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        label30_2.attributedText = attrString

        initializeUI()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait)
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        if( size.width > 1000)
        {
            //graphHeight.constant = 280
        }
        else
        {
            //graphHeight.constant = 409.5
        }
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion:
            {
                _ in
                self.updateUI()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    
    func initializeUI()
    {
        doseSlider1.value = defDoseMg[0]
        doseInput1.text = "\(defDoseMg[0])"
        doseSlider1.maximumValue = defDoseMax[0]
        doseSlider2.value = defDoseMg[1]
        doseInput2.text = "\(defDoseMg[1])"
        doseSlider1.maximumValue = defDoseMax[0]
        doseSlider3.value = defDoseMg[2 ]
        doseInput3.text = "\(defDoseMg[2])"
        doseSlider1.maximumValue = defDoseMax[0]
        doseSlider4.value = defDoseMg[3]
        doseInput4.text = "\(defDoseMg[3])"
        doseSlider1.maximumValue = defDoseMax[0]
        concentrationField.text = "\(defConcentration[0])"
        accumVol = defAccumVol
        yScale = defYScale[0]
        maxYScaleb = 0.1
        hour1 = 0
        minute1 = 0
        hour2 = 12
        minute2 = 0
        timeInput1.text = "00:00"
        timeInput2.text = "12:00"
        updateUI()
    }
    
    func updateUI() -> Void
    {
        var totalDose = doseSlider1.value + doseSlider2.value
        concentrationFieldLabel.text = unitLabel + "/ml"
        doseLabel1.text = unitLabel
        doseLabel2.text = unitLabel
        doseLabel3.text = unitLabel
        doseLabel4.text = unitLabel
        let pumpConText = concentrationField.text!
        let pumpConFloat = (pumpConText as NSString).floatValue
        let bolusGrams = accumVol * pumpConFloat
        let periods = Int(periodStepper.value)
        let minuteArray = calcMinuteArray(stepperState: periods)
        let pumpRate1 = Float(minuteArray[0]) / (doseSlider1.value / bolusGrams)
        let pumpRate1Round = roundValue(inputText: "\(pumpRate1)", roundTo: 1)
        if (pumpRate1Round == "inf")
        {
            rate1.text = "0 Valve Actuations"
        }
        else
        {
            rate1.text = "1 V.A. every \(pumpRate1Round) min"
        }
        let pumpRate2 = Float(minuteArray[1]) / (doseSlider2.value / bolusGrams)
        let pumpRate2Round = roundValue(inputText: "\(pumpRate2)", roundTo: 1)
        if (pumpRate2Round == "inf")
        {
            rate2.text = "0 Valve Actuations"
        }
        else
        {
            rate2.text = "1 V.A. every \(pumpRate2Round) min"
        }
        if(periods > 2)
        {
            let pumpRate3 = Float(minuteArray[2]) / (doseSlider3.value / bolusGrams)
            let pumpRate3Round = roundValue(inputText: "\(pumpRate3)", roundTo: 1)
            if (pumpRate3Round == "inf")
            {
                rate3.text = "0 Valve Actuations"
            }
            else
            {
                rate3.text = "1 V.A. every \(pumpRate3Round) min"
            }
            totalDose += doseSlider3.value
        }
        if(periods > 3)
        {
            let pumpRate4 = Float(minuteArray[3]) / (doseSlider4.value / bolusGrams)
            let pumpRate4Round = roundValue(inputText: "\(pumpRate4)", roundTo: 1)
            if (pumpRate4Round == "inf")
            {
                rate4.text = "0 Valve Actuations"
            }
            else
            {
                rate4.text = "1 V.A. every \(pumpRate4Round) min"
            }
            totalDose += doseSlider4.value
        }
        totalDoseField.text = "\(totalDose)" + " " + unitLabel
        let totalDoseWithPTC = (totalDose / pumpConFloat)   //in mL's
        let daysUntilRefill = Int(pumpVolume / totalDoseWithPTC)
        daysUntilRefillField.text = "\(daysUntilRefill)" + " days"
        pumpVolumeField.text = "\(pumpVolume)"
        accumulatorVolumeField.text = "\(accumVol)"
        generateAndLoadGraph()
        generateAndLoadGraph2()
    }
    
    func calcMinuteArray(stepperState: Int) -> [Int]
    {
        var minuteArray = [Int]()
        let time1 = Int((hour1 * 60) + minute1)
        let time2 = Int((hour2 * 60) + minute2)
        var time3 = 0
        var time4 = 0
        if(stepperState > 2)
        {
            time3 = Int((hour3 * 60) + minute3)
        }
        if(stepperState > 3)
        {
            time4 = Int((hour4 * 60) + minute4)
        }
        var timeElapsed = time2 - time1
        if(timeElapsed < 0){timeElapsed += (24*60)}
        minuteArray.append(timeElapsed)
        if(stepperState == 2)
        {
            timeElapsed = time1 - time2
        }
        else
        {
            timeElapsed = time3 - time2
        }
        if(timeElapsed < 0){timeElapsed += (24*60)}
        minuteArray.append(timeElapsed)
        if(stepperState == 3)
        {
            timeElapsed = time1 - time3
        }
        else
        {
            timeElapsed = time4 - time3
        }
        if(timeElapsed < 0){timeElapsed += (24*60)}
        minuteArray.append(timeElapsed)
        if(stepperState == 4)
        {
            timeElapsed = time1 - time4
            if(timeElapsed < 0){timeElapsed += (24*60)}
            minuteArray.append(timeElapsed)
        }
        return minuteArray
    }
    
    func generateAndLoadGraph() // graphs in terms of dose (mg/mcg)
    {
        //remove old shape layer if any is present
        self.shapeLayer?.removeFromSuperlayer()
        
        //create path for graph to draw
        let stepperState = Int(periodStepper.value)
        let path = UIBezierPath()
        var xCoord = Float(0)
        var yCoord = Float(0)

        
        //ok to use cartesian coordinates, will be shifted when assigning points to path
        var coordArray = [[Int]]()
        var c = 0
        
        let graphX = Float(topGraph.frame.origin.x)
        let graphY = Float(topGraph.frame.origin.y)
        let graphWidth = Float(topGraph.bounds.width)
        let graphHeight = Float(topGraph.bounds.height)
        
        //stores index where beginning of graph should be for later swapping
        var zeroIndex = 0
        
        //points are calculated and added to array
        xCoord += ((hour1 / 24.00) + (minute1 / (24.00 * 60.00))) * graphWidth
        let maxYValue = doseSlider1.maximumValue
        yCoord = (doseSlider1.value / maxYValue) * graphHeight
        var cSet: [Int] = [Int(xCoord), Int(yCoord)]
        coordArray.append(cSet)
        var date1 = timeInput1.text
        var date2 = timeInput1.text
        var sliderVal = doseSlider1.value
        var prevSliderVal = doseSlider2.value
        while(c < stepperState)
        {
            if(c == 0)
            {
                date1 = timeInput1.text
                date2 = timeInput2.text
            }
            else if(c == 1)
            {
                date1 = timeInput2.text
                date2 = timeInput3.text
            }
            else if(c == 2)
            {
                date1 = timeInput3.text
                date2 = timeInput4.text
            }
            else if(c == 3)
            {
                date1 = timeInput4.text
                date2 = timeInput1.text
            }
            
            if(stepperState - c == 1)
            {
                sliderVal = doseSlider1.value
                if(stepperState == 2){ prevSliderVal = doseSlider2.value }
                if(stepperState == 3){ prevSliderVal = doseSlider3.value }
                if(stepperState == 4){ prevSliderVal = doseSlider4.value }
                date2 = timeInput1.text
            }
            else if(c == 0){ sliderVal = doseSlider2.value }
            else if(c == 1){ sliderVal = doseSlider3.value }
            else if(c == 2){ sliderVal = doseSlider4.value }
            
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
            yCoord = (sliderVal / maxYValue) * graphHeight
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
        mainView.layer.addSublayer(shapeLayer)
        
        //save shape layer to viewcontroller
        self.shapeLayer = shapeLayer
    }
    
    
    func generateAndLoadGraph2() // graphs in terms of Valve Actuations (mg/mcg)
    {
        //remove old shape layer if any is present
        self.shapeLayer2?.removeFromSuperlayer()
        
        //create path for graph to draw
        let stepperState = Int(periodStepper.value)
        let path = UIBezierPath()
        var xCoord = Float(0)
        var yCoord = Float(0)
        
        
        //ok to use cartesian coordinates, will be shifted when assigning points to path
        var coordArray = [[Float]]()
        var c = 0
        
        let graphX = Float(bottomGraph.frame.origin.x)
        let graphY = Float(bottomGraph.frame.origin.y)
        let graphWidth = Float(bottomGraph.bounds.width)
        let graphHeight = Float(bottomGraph.bounds.height)
        
        //stores index where beginning of graph should be for later swapping
        var zeroIndex = 0
        
        //points are calculated and added to array
        xCoord += ((hour1 / 24.00) + (minute1 / (24.00 * 60.00))) * graphWidth

        var cSet: [Float] = [xCoord, yCoord]
        coordArray.append(cSet)
        var date1 = timeInput1.text
        var date2 = timeInput1.text
        var sliderVal = doseSlider1.value
        var bolusNumber = 0
        let pumpConText = concentrationField.text!
        let pumpConFloat = (pumpConText as NSString).floatValue
        let bolHeight = ((accumVol * pumpConFloat) / maxYScaleb) * graphHeight
        
        while(c < stepperState)
        {
            if(c == 0)
            {
                date1 = timeInput1.text
                date2 = timeInput2.text
                sliderVal = doseSlider1.value
            }
            else if(c == 1)
            {
                date1 = timeInput2.text
                date2 = timeInput3.text
                sliderVal = doseSlider2.value
            }
            else if(c == 2)
            {
                date1 = timeInput3.text
                date2 = timeInput4.text
                sliderVal = doseSlider3.value
            }
            else if(c == 3)
            {
                date1 = timeInput4.text
                date2 = timeInput1.text
                sliderVal = doseSlider4.value
            }
            if(stepperState - c == 1)
            {
                date2 = timeInput1.text
            }
            
            let pumpConFloat = (concentrationField.text! as NSString).floatValue
            let bolPerPeriod = (sliderVal / pumpConFloat) / accumVol
            let distBetweenBol = (calculateXDistance(startTime: date1!, endTime: date2!, gWidth: graphWidth)) / bolPerPeriod
            bolusNumber = 0
            if(bolPerPeriod == 0)
            {
                xCoord += calculateXDistance(startTime: date1!, endTime: date2!, gWidth: graphWidth)
                if(xCoord > graphWidth)
                {
                    let xDiff = xCoord - graphWidth
                    xCoord = graphWidth
                    cSet = [xCoord, yCoord]
                    coordArray.append(cSet)
                    zeroIndex = coordArray.count
                    xCoord = 0
                    cSet = [xCoord, yCoord]
                    coordArray.append(cSet)
                    xCoord = xDiff
                    cSet = [xCoord, yCoord]
                    coordArray.append(cSet)
                }
                else
                {
                    cSet = [xCoord, yCoord]
                    coordArray.append(cSet)
                }
            }
            else
            {
                while(bolusNumber < Int(bolPerPeriod))
                {
                    yCoord += bolHeight
                    cSet = [xCoord, yCoord]
                    coordArray.append(cSet)
                    yCoord -= bolHeight
                    cSet = [xCoord, yCoord]
                    coordArray.append(cSet)
                    xCoord += distBetweenBol
                    if(xCoord > graphWidth)
                    {
                        let xDiff = xCoord - graphWidth
                        xCoord = graphWidth
                        cSet = [xCoord, yCoord]
                        coordArray.append(cSet)
                        zeroIndex = coordArray.count
                        xCoord = 0
                        cSet = [xCoord, yCoord]
                        coordArray.append(cSet)
                        xCoord = xDiff
                        cSet = [xCoord, yCoord]
                        coordArray.append(cSet)
                    }
                    else
                    {
                        cSet = [xCoord, yCoord]
                        coordArray.append(cSet)
                    }
                    bolusNumber += 1
                }
            }
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
        path.move(to: CGPoint(x: Int(coordArray[0][0] + graphX), y: Int(graphHeight + graphY - coordArray[0][1])))
        while(c < coordArray.count)
        {
            path.addLine(to: CGPoint(x: Int(coordArray[c][0] + graphX), y: Int(graphHeight + graphY - coordArray[c][1])))
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
        mainView.layer.addSublayer(shapeLayer)
        
        
        //save shape layer to viewcontroller
        self.shapeLayer2 = shapeLayer
        
    }
    
    //takes two date objects and the width and calculates length of the multi-rate period in cartesian coordinates
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
