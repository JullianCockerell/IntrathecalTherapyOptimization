//
//  View_ConstantFlow.swift
//  IntrathecalTherapyOptimization
//
//  Created by Jullian Cockerell on 8/1/18.
//  Copyright © 2018 RedRoosterDevelopment. All rights reserved.
//

import UIKit

class View_ConstantFlow: UIViewController, UITextFieldDelegate {

    
    var unitLabel = "mg"
    var roundValue = 3
    var mgMode = true
    var accumVol = Float(0.0025)
    var textHolder = "Not Set"
    var attributingText = false
    var totalDailyBoluses = 0
    var pumpVolume = Float(0)
    var yLabelMax = Float(0.07)
    
    // Defaults: Dose, Concentration, Accumulator Volume, Maximum Dose, Pump Volume
    // index 0 for mg, index 1 for mcg
    let defAccumVol = Float(0.0025)
    let defDose = [Float(0.5), Float(40.0)]
    let defConcentration = [Float(10.0), Float(350.0)]
    let defDoseMax = [Float(5), Float(300)]
    let defPumpVolume = Float(20)
    

    // Main View
    @IBOutlet weak var graphImage: UIImageView!
    @IBOutlet weak var doseSlider: UISlider!
    @IBOutlet weak var pumpRateTextField: UITextField!
    @IBOutlet weak var doseSliderLabel: UILabel!
    @IBOutlet weak var doseInputField: UITextField!
    @IBOutlet weak var pumpConcentrationLabel: UILabel!
    @IBOutlet weak var dosePerClick: UITextField!
    @IBOutlet weak var labelStack24: UIStackView!
    @IBOutlet weak var labelStack30: UIStackView!
    @IBOutlet weak var labelStack6: UIStackView!
    @IBOutlet weak var borderImage: UIImageView!
    @IBOutlet weak var pumpConcentration: UITextField!
    @IBOutlet weak var scalePicker: UISegmentedControl!
    @IBOutlet weak var graphStyle: UIView!
    @IBOutlet weak var graphHeight: NSLayoutConstraint!
    @IBOutlet weak var unitSwitch: UISwitch!
    @IBOutlet weak var advancedSettingsConstraint: NSLayoutConstraint!
    @IBOutlet weak var advancedSettingsOpenButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var yAxisUnitLabel: UILabel!
    @IBOutlet weak var daysUntilRefillBaseField: AllowedCharsTextField!
    @IBOutlet weak var graphStyle2: UIView!
    @IBOutlet weak var graphImage2: UIImageView!
    
    
    // Advanced Settings View
    @IBOutlet weak var advancedSettingsView: UIView!
    @IBOutlet weak var accumulatorVolumeField: UITextField!
    @IBOutlet weak var pumpVolumeField: UITextField!
    @IBOutlet weak var daysUntilRefillField: UITextField!
    @IBOutlet weak var advancedSettingsCloseButton: UIButton!
    @IBOutlet weak var bolusNumField: UITextField!
    @IBOutlet weak var bolusDoseField: UITextField!
    @IBOutlet weak var bolusDoseFieldLabel: UILabel!
    
    //Y-Axis Labels
    @IBOutlet weak var yLabel1: UILabel!
    @IBOutlet weak var yLabel2: UILabel!
    @IBOutlet weak var yLabel3: UILabel!
    @IBOutlet weak var yLabel4: UILabel!
    @IBOutlet weak var yLabel5: UILabel!
    @IBOutlet weak var yLabel6: UILabel!
    @IBOutlet weak var yLabel7: UILabel!
    
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
    @IBOutlet weak var label30_3: UILabel!
    @IBOutlet weak var label30_4: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    

    //****************************************************************//
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        scrollView.setContentOffset(CGPoint(x:0, y:313), animated: true)

        disableInputs(currentTextField: textField)
        textHolder = textField.text!
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)
        {
            textField.selectAll(nil)
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
            var inputText = textField.text!
            if (inputText == "")
            {
                inputText = textHolder
            }
            let inputPrefix = roundValue(inputText: inputText, roundTo: 5)
            textField.text = inputPrefix
            accumVol = (inputPrefix as NSString).floatValue
            updateUI()
        }
        else if(textField == pumpVolumeField)
        {
            pumpVolume = (textField.text! as NSString).floatValue
            activateInputs()
            updateUI()
        }
        else if(textField == pumpConcentration)
        {
            activateInputs()
            var inputText = textField.text!
            if (inputText == "")
            {
                inputText = textHolder
            }
            let inputPrefix = roundValue(inputText: inputText, roundTo: 2)
            textField.text = inputPrefix
            updateUI()
        }
        else if(textField == doseInputField)
        {
            activateInputs()
            var inputText = textField.text!
            if (inputText == "")
            {
                inputText = textHolder
            }
            var inputFloat = (inputText as NSString).floatValue
            if(inputFloat > doseSlider.maximumValue)
            {
                textField.text = "\(doseSlider.maximumValue)"
                inputFloat = doseSlider.maximumValue
                inputText = textField.text!
            }
            else if(inputFloat < doseSlider.minimumValue)
            {
                textField.text = "\(doseSlider.minimumValue)"
                inputFloat = doseSlider.minimumValue
                inputText = textField.text!
            }
            if(!mgMode)
            {
                var inputInt = Int(inputFloat)
                //inputInt = inputInt - (inputInt % 5)
                doseSlider.value = Float(inputInt)
                let doseInputText = "\(doseSlider.value)"
                textField.text = roundValue(inputText: doseInputText, roundTo: 4)
            }
            else
            {
                let inputPrefix = roundValue(inputText: inputText, roundTo: 4)
                doseInputField.text = inputPrefix
                doseSlider.value = inputFloat
            }
            updateUI()
        }
        else
        {
            activateInputs()
            updateUI()
        }
    }
    
    @IBAction func advancedSettingsOpen(_ sender: UIButton)
    {
        advancedSettingsConstraint.constant = 20
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations:
        {
                self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func advancedSettingsClose(_ sender: UIButton)
    {
        advancedSettingsConstraint.constant = 440
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations:
            {
                self.view.layoutIfNeeded()
        })
    }
    

    @IBAction func unitSwitchChanged(_ sender: UISwitch)
    {
        if(mgMode)
        {
            unitLabel = "mcg"
            mgMode = false
            doseSlider.maximumValue = defDoseMax[1]
            doseSlider.value = defDose[1]
            pumpConcentration.text = "\(defConcentration[1])"
            doseInputField.text = "\(defDose[1])"
            bolusNumField.text = "0"
            bolusDoseField.text = "0.0"
            yLabel1.text = "1.0"
            yLabel2.text = "2.0"
            yLabel3.text = "3.0"
            yLabel4.text = "4.0"
            yLabel5.text = "5.0"
            yLabel6.text = "6.0"
            yLabel7.text = "7.0"
            yLabelMax = Float(7)
            yAxisUnitLabel.text = "Dose (" + unitLabel + ")"
        }
        else if(!mgMode)
        {
            unitLabel = "mg"
            mgMode = true
            doseSlider.maximumValue = defDoseMax[0]
            doseSlider.value = defDose[0]
            pumpConcentration.text = "\(defConcentration[0])"
            doseInputField.text = "\(defDose[0])"
            bolusNumField.text = "0"
            bolusDoseField.text = "0.0"
            yLabel1.text = "0.01"
            yLabel2.text = "0.02"
            yLabel3.text = "0.03"
            yLabel4.text = "0.04"
            yLabel5.text = "0.05"
            yLabel6.text = "0.06"
            yLabel7.text = "0.07"
            yLabelMax = Float(0.07)
            yAxisUnitLabel.text = "Dose (" + unitLabel + ")"
        }
        updateUI()
    }
    
    
    @IBAction func doseSliderChanged(_ sender: UISlider)
    {
        if(!mgMode)
        {
            var doseInt = Int(doseSlider.value)
            doseInt = doseInt - (doseInt % 5)
            doseSlider.value = Float(doseInt)
            doseInputField.text = "\(doseSlider.value)"
        }
        else
        {
            let inputVal = doseSlider.value
            var inputText = "\(inputVal)"
            inputText = roundValue(inputText: inputText, roundTo: 1)
            let inputFloat = (inputText as NSString).floatValue
            doseSlider.value = inputFloat
            doseInputField.text = inputText
        }
        updateUI()
    }
    
    func disableInputs(currentTextField: UITextField) -> Void
    {
        if(currentTextField != doseInputField){ doseInputField.isUserInteractionEnabled = false }
        if(currentTextField != pumpConcentration){ pumpConcentration.isUserInteractionEnabled = false }
        if(currentTextField != accumulatorVolumeField){ accumulatorVolumeField.isUserInteractionEnabled = false }
        if(currentTextField != pumpVolumeField){ pumpVolumeField.isUserInteractionEnabled = false }
        if(currentTextField != bolusDoseField){ bolusDoseField.isUserInteractionEnabled = false }
        if(currentTextField != bolusNumField){ bolusNumField.isUserInteractionEnabled = false }
        exitButton.isUserInteractionEnabled = false
        doseSlider.isUserInteractionEnabled = false
        unitSwitch.isUserInteractionEnabled = false
        scalePicker.isUserInteractionEnabled = false
        advancedSettingsOpenButton.isUserInteractionEnabled = false
        advancedSettingsCloseButton.isUserInteractionEnabled = false
    }
    
    func activateInputs() -> Void
    {
        doseInputField.isUserInteractionEnabled = true
        doseSlider.isUserInteractionEnabled = true
        pumpConcentration.isUserInteractionEnabled = true
        unitSwitch.isUserInteractionEnabled = true
        scalePicker.isUserInteractionEnabled = true
        accumulatorVolumeField.isUserInteractionEnabled = true
        pumpVolumeField.isUserInteractionEnabled = true
        advancedSettingsOpenButton.isUserInteractionEnabled = true
        advancedSettingsCloseButton.isUserInteractionEnabled = true
        exitButton.isUserInteractionEnabled = true
        bolusDoseField.isUserInteractionEnabled = true
        bolusNumField.isUserInteractionEnabled = true
    }
    
   
    @IBAction func scalePickerChanged(_ sender: UISegmentedControl)
    {
        let pickerValue = scalePicker.selectedSegmentIndex
        if(pickerValue == 0)
        {
            generateAndLoadGraph()
            generateAndLoadGraph2()
            UIView.animate(withDuration: 0.2, animations: {
                self.labelStack6.alpha = 0.0
                self.labelStack24.alpha = 1.0
                self.labelStack30.alpha = 0.0
            })
        }
        else if (pickerValue == 1)
        {
            generateAndLoadGraph()
            generateAndLoadGraph2()
            UIView.animate(withDuration: 0.2, animations: {
                self.labelStack6.alpha = 1.0
                self.labelStack24.alpha = 0.0
                self.labelStack30.alpha = 0.0
            })
        }
        else if (pickerValue == 2)
        {
            generateAndLoadGraph()
            generateAndLoadGraph2()
            UIView.animate(withDuration: 0.2, animations: {
                self.labelStack6.alpha = 0.0
                self.labelStack24.alpha = 0.0
                self.labelStack30.alpha = 1.0
            })
        }
    
        
    }
    
    weak var shapeLayer: CAShapeLayer?
    weak var shapeLayer2: CAShapeLayer?
    
    func initializeUI()
    {
        doseSlider.value = defDose[0]
        doseSlider.maximumValue = defDoseMax[0]
        doseInputField.text = "\(defDose[0])"
        pumpConcentration.text = "\(defConcentration[0])"
        accumVol = defAccumVol
        accumulatorVolumeField.text = "\(defAccumVol)"
        pumpVolume = defPumpVolume
        pumpVolumeField.text = "\(defPumpVolume)"
        updateUI()
    }
    
    func updateUI() -> Void
    {
        let inputText = doseInputField.text!
        let inputFloat = (inputText as NSString).floatValue
        let inputPrefix = roundValue(inputText: inputText, roundTo: 4)
        doseSlider.value = inputFloat
        let totalDose = doseSlider.value
        let pumpCon = pumpConcentration.text!
        let pumpConFloat = (pumpCon as NSString).floatValue
        var timeBetween = String(Float(1440) / ((totalDose / pumpConFloat) / defAccumVol))
        timeBetween = roundValue(inputText: timeBetween, roundTo: 2)
        if(totalDose == 0)
        {
            pumpRateTextField.text = "0 Valve Actuations"
        }
        else
        {
            pumpRateTextField.text = "1 Valve Actuation every " + timeBetween + " minutes"
        }
        var dosePerClickVal = String(pumpConFloat * accumVol)
        dosePerClickVal = roundValue(inputText: dosePerClickVal, roundTo: 2)
        dosePerClick.text = dosePerClickVal + " " + unitLabel
        doseSliderLabel.text = unitLabel + "/day"
        doseInputField.text = inputPrefix
        pumpConcentrationLabel.text = unitLabel + "/ml"
        bolusDoseFieldLabel.text = unitLabel
        let pumpConText = pumpConcentration.text
        let pumpConRound = roundValue(inputText: pumpConText!, roundTo: 2)
        pumpConcentration.text = pumpConRound
        generateAndLoadGraph()
        generateAndLoadGraph2()
        let ptcVolumeText = bolusNumField.text!
        let ptcVolumeFloat = (ptcVolumeText as NSString).floatValue
        let ptcNumText = bolusDoseField.text!
        let ptcNumFloat = (ptcNumText as NSString).floatValue
        let volPerDay = (doseSlider.value + (ptcNumFloat * ptcVolumeFloat)) / pumpConFloat
        let volPerDayBase = (doseSlider.value) / pumpConFloat
        let daysUntilRefillBase = pumpVolume / volPerDayBase
        if(volPerDayBase == 0)
        {
            daysUntilRefillBaseField.text = "N/A"
        }
        else
        {
            daysUntilRefillBaseField.text = "\(Int(daysUntilRefillBase))"
        }
        let daysUntilRefill = pumpVolume / volPerDay
        if(volPerDay == 0)
        {
            daysUntilRefillField.text = "N/A"
        }
        else
        {
            daysUntilRefillField.text = "\(Int(daysUntilRefill))"
        }
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        if( size.width > 1000)
        {
            graphHeight.constant = 280
        }
        else    
        {
            graphHeight.constant = 409.5
        }
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion:
        {
            _ in
            self.updateUI()
        })
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
    
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait)
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NKInputView.with(doseInputField, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(pumpConcentration, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(accumulatorVolumeField, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(pumpVolumeField, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(bolusDoseField, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(bolusNumField, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        
       
        self.borderImage.layer.borderColor = UIColor.lightGray.cgColor
        self.borderImage.layer.borderWidth = 2
        self.borderImage.layer.cornerRadius = 10
        self.advancedSettingsOpenButton.layer.borderColor = UIColor.lightGray.cgColor
        self.advancedSettingsOpenButton.layer.borderWidth = 2
        self.advancedSettingsOpenButton.layer.cornerRadius = 5
        self.graphStyle.layer.borderWidth = 2
        self.graphStyle.layer.cornerRadius = 10
        self.graphStyle.layer.borderColor = UIColor.lightGray.cgColor
        self.graphStyle2.layer.borderWidth = 2
        self.graphStyle2.layer.cornerRadius = 10
        self.graphStyle2.layer.borderColor = UIColor.lightGray.cgColor
        self.advancedSettingsView.layer.borderWidth = 2
        self.advancedSettingsView.layer.cornerRadius = 10
        self.advancedSettingsView.layer.borderColor = UIColor.lightGray.cgColor
        
        
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
        label30_3.attributedText = attrString
        

    
        initializeUI()
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func generateAndLoadGraph()
    {
        //remove old shape layer if any is present
        self.shapeLayer?.removeFromSuperlayer()
        let graphX = Float(graphImage.frame.origin.x)
        let graphY = Float(graphImage.frame.origin.y)
        let graphWidth = Float(graphImage.bounds.width)
        let graphHeight = Float(graphImage.bounds.height)
        
        //create path for graph to draw
        let path = UIBezierPath()
        var xCoord = Float(0)
        var yCoord = Float(0)
        let totalDose = doseSlider.value
        let pumpCon = pumpConcentration.text!
        let pumpConFloat = (pumpCon as NSString).floatValue
        var bolNum = Int(((totalDose / pumpConFloat) / accumVol))
        totalDailyBoluses = bolNum
        let bolHeight = ((accumVol * pumpConFloat) / yLabelMax) * graphHeight
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
        shapeLayer.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.path = path.cgPath
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineJoin = kCALineJoinRound
        mainView.layer.addSublayer(shapeLayer)
        
        
        //save shape layer to viewcontroller
        self.shapeLayer = shapeLayer
    }

    func generateAndLoadGraph2() //Bottom
    {
        //remove old shape layer if any is present
        self.shapeLayer2?.removeFromSuperlayer()
        let graphX = Float(graphImage2.frame.origin.x)
        let graphY = Float(graphImage2.frame.origin.y)
        let graphWidth = Float(graphImage2.bounds.width)
        let graphHeight = Float(graphImage2.bounds.height)
        
        //create path for graph to draw
        let path = UIBezierPath()
        var xCoord = Float(0)
        var yCoord = Float(0)
        let totalDose = doseSlider.value
        let pumpCon = pumpConcentration.text!
        let pumpConFloat = (pumpCon as NSString).floatValue
        var bolNum = Int(((totalDose / pumpConFloat) / accumVol))
        totalDailyBoluses = bolNum
        let bolHeight = (accumVol / Float(0.007)) * graphHeight   //.007 is max currently
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
        let shapeLayer2 = CAShapeLayer()
        shapeLayer2.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer2.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        shapeLayer2.lineWidth = 3
        shapeLayer2.path = path.cgPath
        shapeLayer2.lineCap = kCALineCapRound
        shapeLayer2.lineJoin = kCALineJoinRound
        mainView.layer.addSublayer(shapeLayer2)
        
        //save shape layer to viewcontroller
        self.shapeLayer2 = shapeLayer2
    }
    
}
