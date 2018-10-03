//
//  View_ConstantFlow.swift
//  IntrathecalTherapyOptimization
//
//  Created by Jullian Cockerell on 8/1/18.
//  Copyright © 2018 RedRoosterDevelopment. All rights reserved.
//

import UIKit

class View_ConstantFlow: UIViewController {

    
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
    let defDose = [Float(1.0), Float(40.0)]
    let defConcentration = [Float(8.0), Float(350.0)]
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
    @IBOutlet weak var graphYMargin: NSLayoutConstraint!
    @IBOutlet weak var scalePicker: UISegmentedControl!
    @IBOutlet weak var graphStyle: UIView!
    @IBOutlet weak var graphHeight: NSLayoutConstraint!
    @IBOutlet weak var unitSwitch: UISwitch!
    @IBOutlet weak var advancedSettingsConstraint: NSLayoutConstraint!
    @IBOutlet weak var advancedSettingsOpenButton: UIButton!
    @IBOutlet weak var outputBorder: UIView!
    @IBOutlet weak var exitButton: UIButton!
    
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
    
    
    
    //****************************************************************//

    @IBAction func bolusNumFieldSelected(_ sender: UITextField)
    {
        textHolder = bolusNumField.text!
        perform(#selector(bolusNumFieldSelectedDelay), with: nil, afterDelay: 0.01)
    }
    
    func bolusNumFieldSelectedDelay() -> Void
    {
        bolusNumField.selectAll(nil)
        disableInputs(activeControl: "bolusNumField")
    }
    
    @IBAction func bolusNumFieldChanged(_ sender: UITextField)
    {
        activateInputs()
        updateUI()
    }
    
    @IBAction func bolusDoseFieldSelected(_ sender: UITextField)
    {
        textHolder = bolusDoseField.text!
        perform(#selector(bolusDoseFieldSelectedDelay), with: nil, afterDelay: 0.01)
    }
    
    func bolusDoseFieldSelectedDelay() -> Void
    {
        bolusDoseField.selectAll(nil)
        disableInputs(activeControl: "bolusDoseField")
    }
    
    @IBAction func bolusDoseFieldChanged(_ sender: UITextField)
    {
        activateInputs()
        updateUI()
    }
    
    @IBAction func accumulatorVolumeFieldSelected(_ sender: AllowedCharsTextField)
    {
        textHolder = pumpConcentration.text!
        perform(#selector(accumulatorVolumeFieldSelectedDelay), with: nil, afterDelay: 0.01)
    }
    
    func accumulatorVolumeFieldSelectedDelay() -> Void
    {
        accumulatorVolumeField.selectAll(nil)
        disableInputs(activeControl: "accumulatorVolumeField")
    }
    
    
    @IBAction func accumulatorVolumeFieldChanged(_ sender: AllowedCharsTextField)
    {
        activateInputs()
        var inputText = accumulatorVolumeField.text!
        if (inputText == "")
        {
            inputText = textHolder
        }
        let inputPrefix = roundValue(inputText: inputText, roundTo: 5)
        accumulatorVolumeField.text = inputPrefix
        accumVol = (inputPrefix as NSString).floatValue
        updateUI()
    }
    
    
    @IBAction func pumpVolumeFieldSelected(_ sender: AllowedCharsTextField)
    {
        textHolder = pumpVolumeField.text!
        perform(#selector(pumpVolumeFieldSelectedDelay), with: nil, afterDelay: 0.01)
    }
    
    func pumpVolumeFieldSelectedDelay() -> Void
    {
        pumpVolumeField.selectAll(nil)
        disableInputs(activeControl: "pumpVolumeField")
    }
    
    
    @IBAction func pumpVolumeFieldChanged(_ sender: AllowedCharsTextField)
    {
        pumpVolume = (pumpVolumeField.text! as NSString).floatValue
        activateInputs()
        updateUI()
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
    
    func disableInputs(activeControl: String) -> Void
    {
        if(activeControl != "doseInputField"){ doseInputField.isUserInteractionEnabled = false }
        if(activeControl != "pumpConcentration"){ pumpConcentration.isUserInteractionEnabled = false }
        if(activeControl != "accumulatorVolumeField"){ accumulatorVolumeField.isUserInteractionEnabled = false }
        if(activeControl != "pumpVolumeField"){ pumpVolumeField.isUserInteractionEnabled = false }
        if(activeControl != "bolusDoseField"){ bolusDoseField.isUserInteractionEnabled = false }
        if(activeControl != "bolusNumField"){ bolusNumField.isUserInteractionEnabled = false }
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
    
    @IBAction func pumpConcentrationSelected(_ sender: AllowedCharsTextField)
    {
        textHolder = pumpConcentration.text!
        perform(#selector(pumpConcentrationSelectedDelay), with: nil, afterDelay: 0.01)
    }
    
    func pumpConcentrationSelectedDelay() -> Void
    {
        pumpConcentration.selectAll(nil)
        disableInputs(activeControl: "pumpConcentration")
        pumpConcentration.isUserInteractionEnabled = true
    }
    
    @IBAction func pumpConcentrationChanged(_ sender: AllowedCharsTextField)
    {
        activateInputs()
        var inputText = pumpConcentration.text!
        if (inputText == "")
        {
            inputText = textHolder
        }
        let inputPrefix = roundValue(inputText: inputText, roundTo: 2)
        pumpConcentration.text = inputPrefix
        updateUI()
    }
    

    @IBAction func doseInputFieldSelected(_ sender: AllowedCharsTextField)
    {
        textHolder = doseInputField.text!
        perform(#selector(doseInputFieldSelectedDelay), with: nil, afterDelay: 0.01)
    }
    
    func doseInputFieldSelectedDelay() -> Void
    {
        doseInputField.selectAll(nil)
        disableInputs(activeControl: "doseInputField")
        doseInputField.isUserInteractionEnabled = true
    }
    
    @IBAction func doseInputFieldChanged(_ sender: AllowedCharsTextField)
    {
        activateInputs()
        var inputText = doseInputField.text!
        if (inputText == "")
        {
            inputText = textHolder
        }
        var inputFloat = (inputText as NSString).floatValue
        if(inputFloat > doseSlider.maximumValue)
        {
            doseInputField.text = "\(doseSlider.maximumValue)"
            inputFloat = doseSlider.maximumValue
            inputText = doseInputField.text!
        }
        else if(inputFloat < doseSlider.minimumValue)
        {
            doseInputField.text = "\(doseSlider.minimumValue)"
            inputFloat = doseSlider.minimumValue
            inputText = doseInputField.text!
        }
        if(!mgMode)
        {
            var inputInt = Int(inputFloat)
            inputInt = inputInt - (inputInt % 5)
            doseSlider.value = Float(inputInt)
            let doseInputText = "\(doseSlider.value)"
            doseInputField.text = roundValue(inputText: doseInputText, roundTo: 2)
        }
        else
        {
            let inputPrefix = roundValue(inputText: inputText, roundTo: 1)
            doseInputField.text = inputPrefix
            doseSlider.value = inputFloat
        }
    
        updateUI()
        
    }
    
    @IBAction func scalePickerChanged(_ sender: UISegmentedControl)
    {
        let pickerValue = scalePicker.selectedSegmentIndex
        if(pickerValue == 0)
        {
            generateAndLoadGraph()
            UIView.animate(withDuration: 0.7, animations: {
                self.labelStack6.alpha = 0.0
                self.labelStack24.alpha = 1.0
                self.labelStack30.alpha = 0.0
            })
        }
        else if (pickerValue == 1)
        {
            generateAndLoadGraph()
            UIView.animate(withDuration: 0.7, animations: {
                self.labelStack6.alpha = 1.0
                self.labelStack24.alpha = 0.0
                self.labelStack30.alpha = 0.0
            })
        }
        else if (pickerValue == 2)
        {
            generateAndLoadGraph()
            UIView.animate(withDuration: 0.7, animations: {
                self.labelStack6.alpha = 0.0
                self.labelStack24.alpha = 0.0
                self.labelStack30.alpha = 1.0
            })
        }
    
        
    }
    
    weak var shapeLayer: CAShapeLayer?
    
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
        let inputPrefix = roundValue(inputText: inputText, roundTo: 1)
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
        doseSliderLabel.text = unitLabel
        doseInputField.text = inputPrefix
        pumpConcentrationLabel.text = unitLabel + "/ml"
        bolusDoseFieldLabel.text = unitLabel
        let pumpConText = pumpConcentration.text
        let pumpConRound = roundValue(inputText: pumpConText!, roundTo: 2)
        pumpConcentration.text = pumpConRound
        generateAndLoadGraph()
        let ptcVolumeText = bolusNumField.text!
        let ptcVolumeFloat = (ptcVolumeText as NSString).floatValue
        let ptcNumText = bolusDoseField.text!
        let ptcNumFloat = (ptcNumText as NSString).floatValue
        let volPerDay = (doseSlider.value + (ptcNumFloat * ptcVolumeFloat)) / pumpConFloat
        let daysUntilRefill = pumpVolume / volPerDay
        daysUntilRefillField.text = "\(daysUntilRefill)"
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(View_ConstantFlow.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(View_ConstantFlow.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        self.borderImage.layer.borderColor = UIColor.lightGray.cgColor
        self.borderImage.layer.borderWidth = 2
        self.borderImage.layer.cornerRadius = 10
        self.outputBorder.layer.borderColor = UIColor.lightGray.cgColor
        self.outputBorder.layer.borderWidth = 2
        self.outputBorder.layer.cornerRadius = 10
        self.advancedSettingsOpenButton.layer.borderColor = UIColor.lightGray.cgColor
        self.advancedSettingsOpenButton.layer.borderWidth = 2
        self.advancedSettingsOpenButton.layer.cornerRadius = 5
        self.graphStyle.layer.borderWidth = 2
        self.graphStyle.layer.cornerRadius = 10
        self.graphStyle.layer.borderColor = UIColor.lightGray.cgColor
        self.advancedSettingsView.layer.borderWidth = 2
        self.advancedSettingsView.layer.cornerRadius = 10
        self.advancedSettingsView.layer.borderColor = UIColor.lightGray.cgColor
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1
        paragraphStyle.lineHeightMultiple = 0.7
        
        let attrString = NSMutableAttributedString(string: "12\nAM")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        label24_1.attributedText = attrString
        
        let attrString2 = NSMutableAttributedString(string: "6\nAM")
        attrString2.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString2.length))
        label24_2.attributedText = attrString2
        
        let attrString3 = NSMutableAttributedString(string: "12\nPM")
        attrString3.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString3.length))
        label24_3.attributedText = attrString3
        
        let attrString4 = NSMutableAttributedString(string: "6\nPM")
        attrString4.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString4.length))
        label24_4.attributedText = attrString4
    
        initializeUI()
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
        view.layer.addSublayer(shapeLayer)
        
        
        //save shape layer to viewcontroller
        self.shapeLayer = shapeLayer
        
    }


    
}
