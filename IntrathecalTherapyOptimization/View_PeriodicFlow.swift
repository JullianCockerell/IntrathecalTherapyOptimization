//
//  View_PeriodicFlow.swift
//  IntrathecalTherapyOptimization
//
//  Created by Jullian Cockerell on 7/31/18.
//  Copyright © 2018 RedRoosterDevelopment. All rights reserved.
//

import UIKit

class View_PeriodicFlow: UIViewController {

    @IBOutlet weak var doseSlider: UISlider!
    @IBOutlet weak var doseSliderLabel: UILabel!
    @IBOutlet weak var intervalStepper: UIStepper!
    @IBOutlet weak var intervalStepperLabel: UILabel!
    @IBOutlet weak var durationPicker: UIDatePicker!
    @IBOutlet weak var graphImage: UIImageView!
    @IBOutlet weak var pumpRateLabel: UITextView!
    @IBOutlet weak var totalDoseLabel: UITextField!
    @IBOutlet weak var warningImage: UIImageView!
    weak var shapeLayer: CAShapeLayer?
    var startMinute = Float(0)
    var startHour = Float(0)
    var mgMode = true
    var unitLabel = "mg"
    var yScale = Float(0.03)
    var accumVol = Float(0.0025)
    var textHolder = ""
    var pumpVolume = Float(20)
    var yScaleMax = Float(0.07)
    var prevStepperVal = 1
    
    // Defaults: Dose, Concentration, Accumulator Volume, Maximum Dose, Y Scale, Pump Volume
    // index 0 for mg, index 1 for mcg
    let defAccumVol = Float(0.0025)
    let defDose = [Float(2.5), Float(50.0)]
    let defConcentration = [Float(8.0), Float(300.0)]
    let defDoseMax = [Float(5), Float(100)]
    let defYScale = [Float(0.03), Float(1.5)]
    let defPumpVolume = Float(20)

    @IBOutlet weak var scalePicker: UISegmentedControl!
    @IBOutlet weak var doseField: AllowedCharsTextField!
    @IBOutlet weak var doseFieldLabel: UILabel!
    @IBOutlet weak var startTimeField: UITextField!
    @IBOutlet weak var unitPicker: UISwitch!
    @IBOutlet weak var labelStack6: UIStackView!
    @IBOutlet weak var labelStack24: UIStackView!
    @IBOutlet weak var labelStack30: UIStackView!
    @IBOutlet weak var graphStyle: UIView!
    @IBOutlet weak var displayStyle: UIView!
    @IBOutlet weak var controlStyle: UIView!
    @IBOutlet weak var pumpConcentration: AllowedCharsTextField!
    @IBOutlet weak var pumpConcentrationLabel: UILabel!
    @IBOutlet weak var graphHeight: NSLayoutConstraint!
    @IBOutlet weak var block1Height: NSLayoutConstraint!
    @IBOutlet weak var block2Height: NSLayoutConstraint!
    @IBOutlet weak var scalePickerHeight: NSLayoutConstraint!
    @IBOutlet weak var block3Height: NSLayoutConstraint!
    @IBOutlet weak var dosePerClickField: UITextField!
    
    @IBOutlet weak var yScale1: UILabel!
    @IBOutlet weak var yScale2: UILabel!
    @IBOutlet weak var yScale3: UILabel!
    @IBOutlet weak var yScale4: UILabel!
    @IBOutlet weak var yScale5: UILabel!
    @IBOutlet weak var yScale6: UILabel!
    @IBOutlet weak var yScale7: UILabel!
    
    // Advanced Settings
    @IBOutlet weak var advancedSettingsView: UIView!
    @IBOutlet weak var advancedSettingsOpenButton: UIButton!
    @IBOutlet weak var accumulatorVolumeField: AllowedCharsTextField!
    @IBOutlet weak var pumpVolumeField: AllowedCharsTextField!
    @IBOutlet weak var daysUntilRefillField: AllowedCharsTextField!
    @IBOutlet weak var advancedSettingsCloseButton: UIButton!
    @IBOutlet weak var advancedSettingsConstraint: NSLayoutConstraint!

    // Time Labels
    @IBOutlet weak var yScale6_1: UILabel!
    @IBOutlet weak var yScale6_2: UILabel!
    @IBOutlet weak var yScale6_3: UILabel!
    @IBOutlet weak var yScale6_4: UILabel!
    @IBOutlet weak var yScale30_1: UILabel!
    @IBOutlet weak var yScale30_2: UILabel!
    
    @IBOutlet weak var label24_1: UILabel!
    @IBOutlet weak var label24_2: UILabel!
    @IBOutlet weak var label24_3: UILabel!
    @IBOutlet weak var label24_4: UILabel!
    
    
    
    
    @IBAction func accumulatorVolumeFieldSelected(_ sender: AllowedCharsTextField)
    {
        textHolder = accumulatorVolumeField.text!
        perform(#selector(accumulatorVolumeFieldSelectedDelayed), with: nil, afterDelay: 0.01)
    }
    
    func accumulatorVolumeFieldSelectedDelayed() -> Void
    {
        accumulatorVolumeField.selectAll(nil)
        disableInputs(activeControl: "accumulatorVolumeField")
    }
    
    @IBAction func accumulatorVolumeFieldChanged(_ sender: AllowedCharsTextField)
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
    
    
    @IBAction func pumpVolumeFieldSelected(_ sender: AllowedCharsTextField)
    {
        textHolder = pumpVolumeField.text!
        perform(#selector(pumpVolumeFieldSelectedDelayed), with: nil, afterDelay: 0.01)
    }
    
    func pumpVolumeFieldSelectedDelayed() -> Void
    {
        pumpVolumeField.selectAll(nil)
        disableInputs(activeControl: "pumpVolumeField")
    }
    
    @IBAction func pumpVolumeFieldChanged(_ sender: AllowedCharsTextField)
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
    
    
    @IBAction func advancedSettingsClose(_ sender: UIButton)
    {
        advancedSettingsConstraint.constant = 510
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
    
    func disableInputs(activeControl: String) -> Void
    {
        if(activeControl != "doseField"){ doseField.isUserInteractionEnabled = false }
        if(activeControl != "startTimeField"){ startTimeField.isUserInteractionEnabled = false }
        if(activeControl != "pumpConcentration"){ pumpConcentration.isUserInteractionEnabled = false }
        if(activeControl != "accumulatorVolumeField"){ accumulatorVolumeField.isUserInteractionEnabled = false }
        if(activeControl != "pumpVolumeField"){ pumpVolumeField.isUserInteractionEnabled = false }
        scalePicker.isUserInteractionEnabled = false
        unitPicker.isUserInteractionEnabled = false
        durationPicker.isUserInteractionEnabled = false
        doseSlider.isUserInteractionEnabled = false
        intervalStepper.isUserInteractionEnabled = false
        advancedSettingsOpenButton.isUserInteractionEnabled = false
        advancedSettingsCloseButton.isUserInteractionEnabled = false
    }
    
    func activateInputs() -> Void
    {
        doseField.isUserInteractionEnabled = true
        doseSlider.isUserInteractionEnabled = true
        pumpConcentration.isUserInteractionEnabled = true
        unitPicker.isUserInteractionEnabled = true
        scalePicker.isUserInteractionEnabled = true
        startTimeField.isUserInteractionEnabled = true
        durationPicker.isUserInteractionEnabled = true
        doseSlider.isUserInteractionEnabled = true
        intervalStepper.isUserInteractionEnabled = true
        advancedSettingsCloseButton.isUserInteractionEnabled = true
        advancedSettingsOpenButton.isUserInteractionEnabled = true
        accumulatorVolumeField.isUserInteractionEnabled = true
        pumpVolumeField.isUserInteractionEnabled = true
    }
    
    @IBAction func startTimeFieldSelected(_ sender: UITextField)
    {
        disableInputs(activeControl: "startTimeField")
    }
        
    @IBAction func doseFieldSelected(_ sender: AllowedCharsTextField)
    {
        textHolder = doseField.text!
        perform(#selector(selectDoseField), with: nil, afterDelay: 0.01)
    }
    
    func selectDoseField() -> Void
    {
        doseField.selectAll(nil)
        disableInputs(activeControl: "doseField")
    }
    
    @IBAction func pumpConcentrationSelected(_ sender: AllowedCharsTextField)
    {
        textHolder = pumpConcentration.text!
        perform(#selector(selectPumpConcentration), with: nil, afterDelay: 0.01)
    }
    
    func selectPumpConcentration() -> Void
    {
        pumpConcentration.selectAll(nil)
        disableInputs(activeControl: "pumpConcentration")
    }
    
    lazy var datePicker: UIDatePicker =
    {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        return picker
    }()
    
    lazy var dateFormatter: DateFormatter =
    {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    @IBAction func pumpConcentrationChaned(_ sender: AllowedCharsTextField)
    {
        activateInputs()
        if(pumpConcentration.text == "")
        {
            pumpConcentration.text = textHolder
        }
        updateUI()
    }
    
    @IBAction func doseFieldChanged(_ sender: UITextField)
    {
        activateInputs()
        var inputText = doseField.text!
        if (inputText == "")
        {
            inputText = textHolder
        }
        var inputFloat = (inputText as NSString).floatValue
        if(inputFloat > doseSlider.maximumValue)
        {
            doseField.text = "\(doseSlider.maximumValue)"
            inputFloat = doseSlider.maximumValue
            inputText = doseField.text!
        }
        else if(inputFloat < doseSlider.minimumValue)
        {
            doseField.text = "\(doseSlider.minimumValue)"
            inputFloat = doseSlider.minimumValue
            inputText = doseField.text!
        }
        if(!mgMode)
        {
            let inputInt = Int(inputFloat)
            //inputInt = inputInt - (inputInt % 5)
            doseSlider.value = Float(inputInt)
            let doseInputText = "\(doseSlider.value)"
            doseField.text = roundValue(inputText: doseInputText, roundTo: 4)
        }
        else
        {
            let inputPrefix = roundValue(inputText: inputText, roundTo: 4)
            doseField.text = inputPrefix
            doseSlider.value = inputFloat
        }
        updateUI()
    }
    
    func initializeUI()
    {
        doseSlider.value = defDose[0]
        doseSlider.maximumValue = defDoseMax[0]
        doseField.text = "\(defDose[0])"
        pumpConcentration.text = "\(defConcentration[0])"
        accumVol = defAccumVol
        yScale = defYScale[0]
        // setYScaleLabels()
        updateUI()
    }
    
    func updateUI()
    {
        let inputText = doseField.text!
        let inputFloat = (inputText as NSString).floatValue
        let inputPrefix = roundValue(inputText: inputText, roundTo: 4)
        doseSlider.value = inputFloat
        doseField.text = inputPrefix
        let totalDose = doseSlider.value * Float(intervalStepper.value)
        totalDoseLabel.text = roundValue(inputText: "\(totalDose)", roundTo: 2) + " " + unitLabel
        let components = Calendar.current.dateComponents([.hour, .minute], from: durationPicker.date)
        let durHour = Float(components.hour!)
        let durMinute = Float(components.minute!)
        let pumpConText = pumpConcentration.text!
        let pumpConFloat = (pumpConText as NSString).floatValue
        let bolusGrams = accumVol * pumpConFloat
        let durTotal = (60*durHour) + durMinute
        let pumpClicksNum = inputFloat / bolusGrams
        let pumpRateInClicks = durTotal / pumpClicksNum
        let dosePerClickFloat = Float(accumVol) * pumpConFloat
        dosePerClickField.text = roundValue(inputText: "\(dosePerClickFloat)", roundTo: 4) + " " + unitLabel
        if(pumpClicksNum == 0)
        {
            pumpRateLabel.text = "0 Valve Actuations"
        }
        else
        {
            pumpRateLabel.text = "1 Valve Actuation every " + roundValue(inputText: "\(pumpRateInClicks)", roundTo: 2) + " min"
        }
        doseFieldLabel.text = unitLabel + "/bolus"
        pumpConcentrationLabel.text = unitLabel + "/ml"
        let totalDoseWithPTC = (totalDose / pumpConFloat)   //in mL's
        if(totalDoseWithPTC > 0)
        {
            let daysUntilRefill = Int(pumpVolume / totalDoseWithPTC)
            daysUntilRefillField.text = "\(daysUntilRefill)" + " days"
        }
        else
        {
            daysUntilRefillField.text = "N/A"
        }
        
        pumpVolumeField.text = "\(pumpVolume)"
        accumulatorVolumeField.text = "\(accumVol)"
        generateAndLoadGraph()
    }
    
    @IBAction func unitPickerChanged(_ sender: UISwitch)
    {
        if(mgMode)
        {
            mgMode = false
            unitLabel = "mcg"
            doseSlider.maximumValue = defDoseMax[1]
            doseSlider.value = defDose[1]
            doseField.text = "\(defDose[1])"
            pumpConcentration.text = "\(defConcentration[1])"
            yScale = defYScale[1]
            
            yScale1.text = "1.0"
            yScale2.text = "2.0"
            yScale3.text = "3.0"
            yScale4.text = "4.0"
            yScale5.text = "5.0"
            yScale6.text = "6.0"
            yScale7.text = "7.0"
            yScaleMax = Float(7)
        }
        else
        {
            mgMode = true
            unitLabel = "mg"
            doseSlider.maximumValue = defDoseMax[0]
            doseSlider.value = defDose[0]
            doseField.text = "\(defDose[0])"
            yScale = defYScale[0]
            pumpConcentration.text = "\(defConcentration[0])"
            
            yScale1.text = "0.01"
            yScale2.text = "0.02"
            yScale3.text = "0.03"
            yScale4.text = "0.04"
            yScale5.text = "0.05"
            yScale6.text = "0.06"
            yScale7.text = "0.07"
            yScaleMax = Float(0.07)
        }
        updateUI()
    }
    
    /*func setYScaleLabels() -> Void
    {
        let maxRate = Float(0.005)
        let maxRateInterval = (maxRate / 10)
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
        yScale6.text = roundValue(inputText: "\(maxRateInterval * 6)", roundTo: roundNumber)
        yScale7.text = roundValue(inputText: "\(maxRateInterval * 7)", roundTo: roundNumber)
        yScale8.text = roundValue(inputText: "\(maxRateInterval * 8)", roundTo: roundNumber)
        yScale9.text = roundValue(inputText: "\(maxRateInterval * 9)", roundTo: roundNumber)
        yScale10.text = roundValue(inputText: "\(maxRateInterval * 10)", roundTo: roundNumber)
    }*/
    
    
    @IBAction func scalePickerChanged(_ sender: UISegmentedControl)
    {
        let pickerValue = scalePicker.selectedSegmentIndex
        if(pickerValue == 0)
        {
            generateAndLoadGraph()
            UIView.animate(withDuration: 0.5, animations: {
                self.labelStack6.alpha = 0.0
                self.labelStack24.alpha = 1.0
                self.labelStack30.alpha = 0.0
            })
        }
        else if (pickerValue == 1)
        {
            generateAndLoadGraph()
            UIView.animate(withDuration: 0.5, animations: {
                self.labelStack6.alpha = 1.0
                self.labelStack24.alpha = 0.0
                self.labelStack30.alpha = 0.0
            })
        }
        else if (pickerValue == 2)
        {
            generateAndLoadGraph()
            UIView.animate(withDuration: 0.5, animations: {
                self.labelStack6.alpha = 0.0
                self.labelStack24.alpha = 0.0
                self.labelStack30.alpha = 1.0
            })
        }
    }
    
    @IBAction func doseSliderChanged(_ sender: UISlider)
    {
        if(!mgMode)
        {
            var doseInt = Int(doseSlider.value)
            doseInt = doseInt - (doseInt % 5)
            doseSlider.value = Float(doseInt)
            var doseValue = "\(doseSlider.value)"
            doseValue = roundValue(inputText: doseValue, roundTo: 1)
            doseField.text = doseValue
        }
        else
        {
            let inputText = "\(doseSlider.value)"
            let inputPrefix = roundValue(inputText: inputText, roundTo: 1)
            let inputFloat = (inputPrefix as NSString).floatValue
            doseSlider.value = inputFloat
            doseField.text = inputPrefix
        }
        updateUI()
    }
    
    @IBAction func durationPickerChanged(_ sender: UIDatePicker)
    {
        if(isValid())
        {
            updateUI()
        }
        else
        {
            self.shapeLayer?.removeFromSuperlayer()
        }
    }
    
    @IBAction func intervalStepperChanged(_ sender: UIStepper)
    {
        var cVal = Int(sender.value)
        if(cVal == 7 && prevStepperVal == 6) { cVal = 8 }
        if(cVal == 7 && prevStepperVal == 8) { cVal = 6 }
        if(cVal == 11 && prevStepperVal == 10) { cVal = 12 }
        if(cVal == 11 && prevStepperVal == 12){ cVal = 10 }
        if(cVal == 13) { cVal = 15 }
        if(cVal == 14) { cVal = 12 }
        if(cVal == 17 && prevStepperVal == 16) { cVal = 18 }
        if(cVal == 17 && prevStepperVal == 18) { cVal = 16 }
        if(cVal == 19 && prevStepperVal == 18) { cVal = 20 }
        if(cVal == 19 && prevStepperVal == 20) { cVal = 18 }
        if(cVal == 21) { cVal = 24 }
        if(cVal == 23) { cVal = 20 }
        
        
        intervalStepper.value = Double(cVal)
        if (cVal == 1)
        {
            intervalStepperLabel.text = "\(cVal)" + " Period"
        }
        else
        {
            intervalStepperLabel.text = "\(cVal)" + " Periods"
        }
        if(isValid())
        {
            updateUI()
        }
        prevStepperVal = cVal
    }
    
    func isValid() -> Bool
    {
        let components = Calendar.current.dateComponents([.hour, .minute], from: durationPicker.date)
        let durTotal = ((Float(components.hour!)/24.00) + (Float(components.minute!)/(24.00*60.00))) * Float(Int(intervalStepper.value))
        if durTotal > 1.00
        {
            warningImage.alpha = 0.9
        }
        else
        {
            warningImage.alpha = 0.00
        }
        return(durTotal <= 1.00)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        if( size.width > 1000)
        {
            graphHeight.constant = 260
            block1Height.constant = 10
            block2Height.constant = 30
            block3Height.constant = 40
            scalePickerHeight.constant = 35
        }
        else
        {
            graphHeight.constant = 370
            block1Height.constant = 30
            block2Height.constant = 40
            block3Height.constant = 50
            scalePickerHeight.constant = 50
        }
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion:
            {
                _ in
                self.updateUI()
        })
    }

    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait)
    }
    
    func generateAndLoadGraph()
    {
        //remove old shape layer if any is present
        self.shapeLayer?.removeFromSuperlayer()
        let graphX = Float(graphImage.frame.origin.x)
        let graphY = Float(graphImage.frame.origin.y)
        let graphWidth = Float(graphImage.bounds.width)
        let graphHeight = Float(graphImage.bounds.height)
        var scaling = scalePicker.selectedSegmentIndex
        
        //create path for graph to draw
        let path = UIBezierPath()
        var xShift = Float(0)
        
        let bolNum = Float(intervalStepper.value)
        let cycWidth = graphWidth / bolNum
        
        var xCoord = Float(0)
        var yCoord = Float(0)
        let components = Calendar.current.dateComponents([.hour, .minute], from: durationPicker.date)
        let durHour = Float(components.hour!)
        let durMinute = Float(components.minute!)
        let durTotal = (60*durHour) + durMinute
        
        let pumpConText = pumpConcentration.text!
        let pumpConFloat = (pumpConText as NSString).floatValue
        // let flowRate = bolusRate / pumpConFloat
        // let bolHeight = (bolusRate / maxBolusRate) * graphHeight
        let bolHeight = ((accumVol * pumpConFloat) / yScaleMax) * graphHeight
        let bolWidth = (durTotal / (60*24)) * graphWidth
        let basWidth = cycWidth - bolWidth
        
        let bolPerPeriod = (doseSlider.value / pumpConFloat) / accumVol
        let distBetweenBol = ((durTotal / bolPerPeriod) / (24*60)) * graphWidth    //in coordinate points
        /*if(((durTotal / bolPerPeriod)) < 18)
        {
            scaling = 1
            scalePicker.selectedSegmentIndex = 1
        }*/
        if(scaling == 0)
        {
            xShift = Float(((startHour + (startMinute/Float(60))) / 24)) * graphWidth
        }
        
        
        //ok to use cartesian coordinates, will be shifted when assigning points to path
        var coordArray = [[Float]]()
        var c = 0
        var bolCounter = 0
        xCoord += xShift
        var cSet: [Float] = [xCoord, yCoord]
        coordArray.append(cSet)
        //stores index where beginning of graph is for later swapping
        var zeroIndex = 0
        //points are calculated and added to array
        while (c < Int(bolNum))
        {
            bolCounter = 0
            while(bolCounter < Int(bolPerPeriod))
            {
                yCoord += bolHeight
                cSet = [xCoord, yCoord]
                coordArray.append(cSet)
                yCoord -= bolHeight
                cSet = [xCoord, yCoord]
                coordArray.append(cSet)
                xCoord += distBetweenBol
                if (xCoord > graphWidth)
                {
                    cSet = [graphWidth, yCoord]
                    coordArray.append(cSet)
                    zeroIndex = coordArray.count
                    xCoord = xCoord - graphWidth
                    cSet = [0, yCoord]
                    coordArray.append(cSet)
                    cSet = [xCoord, yCoord]
                    coordArray.append(cSet)
                }
                else
                {
                    cSet = [xCoord, yCoord]
                    coordArray.append(cSet)
                }
                bolCounter += 1
            }
            xCoord += basWidth
            if (xCoord > graphWidth)
            {
                cSet = [graphWidth, yCoord]
                coordArray.append(cSet)
                zeroIndex = coordArray.count
                xCoord = xCoord - graphWidth
                cSet = [0, yCoord]
                coordArray.append(cSet)
                cSet = [xCoord, yCoord]
                coordArray.append(cSet)
                
            }
            else
            {
                cSet = [xCoord, yCoord]
                coordArray.append(cSet)
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
        
        //scaling is applied if zoom feature is in use
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
            var nextHour = startHour
            var nextMin = startMinute
            var minSpacer = ""
            var timeLabel = "AM"
            if(nextHour > 12)
            {
                timeLabel = "PM"
                nextHour = nextHour - 12
            }
            if(nextMin < 10){minSpacer = "0"}
            yScale6_1.text = "\(Int(nextHour))" + ":" + minSpacer + "\(Int(nextMin))" + timeLabel
            var c2 = 0
            while(c2 < 3)
            {
                minSpacer = ""
                nextMin += 30
                if(nextMin > 59)
                {
                    nextHour += 1
                    nextMin -= 60
                }
                nextHour += 1
                if(nextHour > 12)
                {
                    if(timeLabel == "PM"){timeLabel = "AM"}
                    else if(timeLabel == "AM"){timeLabel = "PM"}
                    nextHour -= 12
                }
                if(c2 == 0)
                {
                    if(nextMin < 10){minSpacer = "0"}
                    yScale6_2.text = "\(Int(nextHour))" + ":" + minSpacer + "\(Int(nextMin))" + timeLabel
                }
                if(c2 == 1)
                {
                    if(startMinute < 10){minSpacer = "0"}
                    yScale6_3.text = "\(Int(nextHour))" + ":" + minSpacer + "\(Int(nextMin))" + timeLabel
                }
                if(c2 == 2)
                {
                    if(startMinute < 10){minSpacer = "0"}
                    yScale6_4.text = "\(Int(nextHour))" + ":" + minSpacer + "\(Int(nextMin))" + timeLabel
                }
                c2 += 1
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
            var nextHour = startHour
            var nextMin = startMinute
            var minSpacer = ""
            var timeLabel = "AM"
            if(nextHour > 12)
            {
                timeLabel = "PM"
                nextHour = nextHour - 12
            }
            if(nextMin < 10){minSpacer = "0"}
            yScale30_1.text = "\(Int(nextHour))" + ":" + minSpacer + "\(Int(nextMin))" + timeLabel
            
            nextMin += 15
            minSpacer = ""
            if(nextMin > 59)
            {
                nextHour += 1
                nextMin -= 60
            }
            if(nextHour > 12)
            {
                if(timeLabel == "PM"){timeLabel = "AM"}
                else if(timeLabel == "AM"){timeLabel = "PM"}
                nextHour -= 12
            }
            if(nextMin < 10){minSpacer = "0"}
            yScale30_2.text = "\(Int(nextHour))" + ":" + minSpacer + "\(Int(nextMin))" + timeLabel

        }
        
        //add points to path
        c = 1
        path.move(to: CGPoint(x: Int(coordArray[0][0] + graphX), y: Int(graphHeight + graphY - coordArray[0][1])))
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
        
        //create shape layer for that path
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.path = path.cgPath
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineJoin = kCALineJoinRound
        view.layer.addSublayer(shapeLayer)

        
        //save shape layer to viewcontroller
        self.shapeLayer = shapeLayer
    }
    
    func generateAndLoadGraph2()    //deprecated
    {
        //remove old shape layer if any is present
        self.shapeLayer?.removeFromSuperlayer()
        let graphX = Float(graphImage.frame.origin.x)
        let graphY = Float(graphImage.frame.origin.y)
        let graphWidth = Float(graphImage.bounds.width)
        let graphHeight = Float(graphImage.bounds.height)
        
        
        //create path for graph to draw
        //assign base constants
        let path = UIBezierPath()
        let xShift = Float(((startHour + (startMinute/Float(60))) / 24))*graphWidth
        let bolNum = Float(intervalStepper.value)
        let cycWidth = graphWidth / bolNum
        
        var xCoord = Float(0)
        var yCoord = Float(0)
        let components = Calendar.current.dateComponents([.hour, .minute], from: durationPicker.date)
        let durHour = Float(components.hour!)
        let durMinute = Float(components.minute!)
        let durTotal = (60*durHour) + durMinute
        
        let bolusRate = doseSlider.value / durTotal
        let maxBolusRate = doseSlider.maximumValue / 10
        let bolHeight = (bolusRate / maxBolusRate) * graphHeight
        
        let bolWidth = (durTotal / (60*24)) * graphWidth
        let basWidth = cycWidth - bolWidth
        
        //ok to use cartesian coordinates, will be shifted when assigning points to path
        var coordArray = [[Float]]()
        var c = 0
        xCoord += xShift
        var cSet: [Float] = [xCoord, yCoord]
        coordArray.append(cSet)
        //stores index where beginning of graph is for later swapping
        var zeroIndex = 0
        //points are calculated and added to array
        while (c < Int(bolNum))
        {
            yCoord = yCoord + bolHeight
            cSet = [xCoord, yCoord]
            coordArray.append(cSet)
            xCoord += bolWidth
            if (xCoord > graphWidth)
            {
                cSet = [graphWidth, yCoord]
                coordArray.append(cSet)
                zeroIndex = coordArray.count
                xCoord = xCoord - graphWidth
                cSet = [0, yCoord]
                coordArray.append(cSet)
                cSet = [xCoord, yCoord]
                coordArray.append(cSet)
                
            }
            else
            {
                cSet = [xCoord, yCoord]
                coordArray.append(cSet)
            }
            yCoord = yCoord - bolHeight
            cSet = [xCoord, yCoord]
            coordArray.append(cSet)
            xCoord += basWidth
            if (xCoord > graphWidth)
            {
                cSet = [graphWidth, yCoord]
                coordArray.append(cSet)
                zeroIndex = coordArray.count
                xCoord = xCoord - graphWidth
                cSet = [0, yCoord]
                coordArray.append(cSet)
                cSet = [xCoord, yCoord]
                coordArray.append(cSet)
                
            }
            else
            {
                cSet = [xCoord, yCoord]
                coordArray.append(cSet)
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
        
        //scaling is applied if zoom feature is in use
        let scaling = scalePicker.selectedSegmentIndex
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
        }
        
        //add points to path
        c = 1
        path.move(to: CGPoint(x: Int(coordArray[0][0] + graphX), y: Int(graphHeight + graphY - coordArray[0][1])))
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
        
        //create shape layer for that path
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.path = path.cgPath
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineJoin = kCALineJoinRound
        view.layer.addSublayer(shapeLayer)
        
        
        //save shape layer to viewcontroller
        self.shapeLayer = shapeLayer
        
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
    
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(View_PeriodicFlow.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(View_PeriodicFlow.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NKInputView.with(doseField, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(pumpConcentration, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(accumulatorVolumeField, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(pumpVolumeField, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        
        startTimeField.inputView = datePicker
        let toolBar = UIToolbar().ToolbarPicker(mySelect: #selector(View_PeriodicFlow.dismissPicker))
        startTimeField.inputAccessoryView = toolBar
        
        pumpRateLabel.centerVertically()
        self.pumpRateLabel.layer.borderColor = UIColor.lightGray.cgColor
        self.pumpRateLabel.layer.cornerRadius = 5
        let borderColor = UIColor.lightGray.cgColor
        self.advancedSettingsView.layer.borderWidth = 2
        self.advancedSettingsView.layer.cornerRadius = 10
        self.advancedSettingsView.layer.borderColor = UIColor.lightGray.cgColor
        durationPicker.layer.borderColor = borderColor
        durationPicker.layer.borderWidth = 2.0
        durationPicker.layer.cornerRadius = 5
        durationPicker.setValue(UIColor.white, forKeyPath: "textColor")
        graphStyle.layer.cornerRadius = 10
        graphStyle.layer.borderColor = borderColor
        graphStyle.layer.borderWidth = 2
        displayStyle.layer.cornerRadius = 10
        displayStyle.layer.borderColor = borderColor
        displayStyle.layer.borderWidth = 2
        controlStyle.layer.cornerRadius = 10
        controlStyle.layer.borderColor = borderColor
        controlStyle.layer.borderWidth = 2
        self.advancedSettingsOpenButton.layer.borderColor = UIColor.lightGray.cgColor
        self.advancedSettingsOpenButton.layer.borderWidth = 2
        self.advancedSettingsOpenButton.layer.cornerRadius = 5
        
        let date = Date()
        let calendar = Calendar.current
        startHour = Float(calendar.component(.hour, from: date))
        startMinute = Float(calendar.component(.minute, from: date))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let initDateTime = formatter.date(from: "2016/10/08 00:10")
        durationPicker.setDate(initDateTime!, animated: true)
        var currentHourVar = startHour
        var timeLabel = "AM"
        if(currentHourVar > 12)
        {
            currentHourVar -= 12
            timeLabel = "PM"
        }
        var minuteSpacer = ""
        if(startMinute < 10)
        {
            minuteSpacer = "0"
        }
        startTimeField.text = "\(Int(currentHourVar))" + ":" + minuteSpacer + "\(Int(startMinute))" + " " + timeLabel
        
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
        yScale6_1.attributedText = attrString
        
        attrString = NSMutableAttributedString(string: "1:30\nAM")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        yScale6_2.attributedText = attrString
        
        attrString = NSMutableAttributedString(string: "3\nAM")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        yScale6_3.attributedText = attrString
        
        attrString = NSMutableAttributedString(string: "4:30\nAM")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        yScale6_4.attributedText = attrString
        
        attrString = NSMutableAttributedString(string: "12\nAM")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        yScale30_1.attributedText = attrString
        
        attrString = NSMutableAttributedString(string: "12:15\nAM")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        yScale30_2.attributedText = attrString

        
        initializeUI()
    }
    
    func dismissPicker()
    {
        activateInputs()
        view.endEditing(true)
        let components = Calendar.current.dateComponents([.hour, .minute], from: datePicker.date)
        startHour = Float(components.hour!)
        startMinute = Float(components.minute!)
        startTimeField.text = dateFormatter.string(from: datePicker.date)
        updateUI()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func keyboardWillShow(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
}

extension UITextView {
    
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
    
}
