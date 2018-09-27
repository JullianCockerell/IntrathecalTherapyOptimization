//
//  View_MatchMyTrial.swift
//  IntrathecalTherapyOptimization
//
//  Created by Jullian Cockerell on 9/5/18.
//  Copyright © 2018 RedRoosterDevelopment. All rights reserved.
//

import UIKit

class View_MatchMyTrial: UIViewController
{
    let defPumpCon = Float(20)
    let defAccumVol = Float(0.0025)

    var textHolder = ""
    var selectedHour = 0
    var selectedMinute = 0
    var mgMode = true
    var unitLabel = "mg"
    var gBolNum = 0
    var pumpVolume = Float(20)
    var accumVol = Float(0.0025)
    
    
    @IBOutlet weak var graphImage: UIImageView!
    @IBOutlet weak var scalePicker: UISegmentedControl!
    @IBOutlet weak var trialDoseField: AllowedCharsTextField!
    @IBOutlet weak var trialDoseLabel: UILabel!
    @IBOutlet weak var matchTrialButton: UIButton!
    @IBOutlet weak var reliefDuration: UITextField!
    @IBOutlet weak var bolusNumField: UITextField!
    @IBOutlet weak var bolusIntervalField: UITextField!
    @IBOutlet weak var dosePerBolusField: UITextField!
    @IBOutlet weak var dosePerBolusLabel: UILabel!
    @IBOutlet weak var totalDailyDoseField: UITextField!
    @IBOutlet weak var totalDailyDoseLabel: UILabel!
    @IBOutlet weak var unitSwitch: UISwitch!
    @IBOutlet weak var exitButton: UIButton!
    
    @IBOutlet weak var labelStack24: UIStackView!
    @IBOutlet weak var labelStack30: UIStackView!
    @IBOutlet weak var labelStack6: UIStackView!
    
    @IBOutlet weak var graphBorder: UIView!
    @IBOutlet weak var controlBorder: UIView!
    @IBOutlet weak var displayBorder: UIView!
    
    // Advanced Settings
    @IBOutlet weak var advancedSettingsView: UIView!
    @IBOutlet weak var advancedSettingsOpenButton: UIButton!
    @IBOutlet weak var advancedSettingsCloseButton: UIButton!
    @IBOutlet weak var accumulatorVolumeField: AllowedCharsTextField!
    @IBOutlet weak var pumpVolumeField: AllowedCharsTextField!
    @IBOutlet weak var bolusDoseField: UITextField!
    @IBOutlet weak var ptcBolusNumField: AllowedCharsTextField!
    @IBOutlet weak var daysUntilRefillField: AllowedCharsTextField!
    @IBOutlet weak var bolusDoseLabel: UILabel!
    @IBOutlet weak var advancedSettingsConstraint: NSLayoutConstraint!
    
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
        advancedSettingsConstraint.constant = 480
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations:
        {
            self.view.layoutIfNeeded()
        })
    }
    
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
    
    @IBAction func ptcBolusNumFieldSelected(_ sender: AllowedCharsTextField)
    {
        textHolder = ptcBolusNumField.text!
        perform(#selector(ptcBolusNumFieldSelectedDelayed), with: nil, afterDelay: 0.01)
    }
    
    func ptcBolusNumFieldSelectedDelayed() -> Void
    {
        bolusNumField.selectAll(nil)
        disableInputs(activeControl: "ptcBolusNumField")
    }
    
    @IBAction func ptcBolusNumFieldChanged(_ sender: AllowedCharsTextField)
    {
        activateInputs()
        if(ptcBolusNumField.text == "")
        {
            ptcBolusNumField.text = textHolder
        }
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
    
    @IBAction func bolusDoseFieldSelected(_ sender: UITextField)
    {
        textHolder = bolusDoseField.text!
        perform(#selector(bolusDoseFieldSelectedDelayed), with: nil, afterDelay: 0.01)
    }
    
    func bolusDoseFieldSelectedDelayed() -> Void
    {
        bolusDoseField.selectAll(nil)
        disableInputs(activeControl: "bolusDoseField")
    }
    
    @IBAction func bolusDoseFieldChanged(_ sender: UITextField)
    {
        activateInputs()
        if(bolusDoseField.text == "")
        {
            bolusDoseField.text = textHolder
        }
        updateUI()
    }
    
    
    @IBAction func trialDoseFieldSelected(_ sender: AllowedCharsTextField)
    {
        textHolder = trialDoseField.text!
        perform(#selector(trialDoseFieldSelectedDelayed), with: nil, afterDelay: 0.01)
    }
    
    func trialDoseFieldSelectedDelayed()
    {
        trialDoseField.selectAll(nil)
        disableInputs(activeControl: "trialDoseField")
    }
    
    @IBAction func trialDoseFieldChanged(_ sender: AllowedCharsTextField)
    {
        activateInputs()
        if (trialDoseField.text == "")
        {
            trialDoseField.text = textHolder
        }
    }
    
    @IBAction func reliefDurationSelected(_ sender: UITextField)
    {
        disableInputs(activeControl: "reliefDuration")
    }
    
    
    @IBAction func reliefDurationChanged(_ sender: UITextField)
    {
        activateInputs()
    }
    
    
    @IBAction func unitSwitchChanged(_ sender: UISwitch)
    {
        if(mgMode)
        {
            mgMode = false
            unitLabel = "mcg"
            totalDailyDoseLabel.text = unitLabel
            dosePerBolusLabel.text = unitLabel
            trialDoseLabel.text = unitLabel
        }
        else
        {
            mgMode = true
            unitLabel = "mg"
            totalDailyDoseLabel.text = unitLabel
            dosePerBolusLabel.text = unitLabel
            trialDoseLabel.text = unitLabel
        }
    }
    
    @IBAction func matchTrial(_ sender: UIButton)
    {
        updateUI()
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

        }
        else
        {

        }
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion:
            {
                _ in
                self.updateUI()
        })
    }
    
    func updateUI() -> Void
    {
        generateAndLoadGraph()
        trialDoseLabel.text = unitLabel
        dosePerBolusLabel.text = unitLabel
        totalDailyDoseLabel.text = unitLabel
        bolusNumField.text = "\(gBolNum)"
        dosePerBolusField.text = trialDoseField.text
        let bolusIntervalMin = round(Float(1440) / Float(gBolNum))
        let bolusIntervalMinute = Int(bolusIntervalMin) % 60
        let bolusIntervalHour = (Int(bolusIntervalMin) - bolusIntervalMinute) / 60
        bolusIntervalField.text = "\(bolusIntervalHour)" + " hr " + "\(bolusIntervalMinute)" + " min"
        let trialDoseText = trialDoseField.text!
        let trialDoseFloat = (trialDoseText as NSString).floatValue
        let totalDose = Float(gBolNum) * trialDoseFloat
        totalDailyDoseField.text = "\(totalDose)"
        let pumpConFloat = Float(8.0)
        
        let totalDoseCon = (totalDose / pumpConFloat)   //in mL's
        daysUntilRefillField.text = "\(pumpVolume / totalDoseCon)" + " days"
        pumpVolumeField.text = "\(pumpVolume)"
        accumulatorVolumeField.text = "\(accumVol)"
    }

    func activateInputs() -> Void
    {
        scalePicker.isUserInteractionEnabled = true
        trialDoseField.isUserInteractionEnabled = true
        reliefDuration.isUserInteractionEnabled = true
        unitSwitch.isUserInteractionEnabled = true
        reliefDuration.isUserInteractionEnabled = true
        matchTrialButton.isUserInteractionEnabled = true
        exitButton.isUserInteractionEnabled = true
        advancedSettingsOpenButton.isUserInteractionEnabled = true
        advancedSettingsCloseButton.isUserInteractionEnabled = true
        accumulatorVolumeField.isUserInteractionEnabled = true
        pumpVolumeField.isUserInteractionEnabled = true
        bolusDoseField.isUserInteractionEnabled = true
        ptcBolusNumField.isUserInteractionEnabled = true
    }
    
    func disableInputs(activeControl: String) -> Void
    {
        if(activeControl != "trialDoseField"){ trialDoseField.isUserInteractionEnabled = false }
        if(activeControl != "reliefDuration"){ reliefDuration.isUserInteractionEnabled = false }
        if(activeControl != "accumulatorVolumeField"){ accumulatorVolumeField.isUserInteractionEnabled = false }
        if(activeControl != "pumpVolumeField"){ pumpVolumeField.isUserInteractionEnabled = false }
        if(activeControl != "ptcBolusNumField"){ ptcBolusNumField.isUserInteractionEnabled = false }
        if(activeControl != "bolusDoseField"){ bolusDoseField.isUserInteractionEnabled = false }
        scalePicker.isUserInteractionEnabled = false
        unitSwitch.isUserInteractionEnabled = false
        matchTrialButton.isUserInteractionEnabled = false
        exitButton.isUserInteractionEnabled = false
        advancedSettingsCloseButton.isUserInteractionEnabled = false
        advancedSettingsOpenButton.isUserInteractionEnabled = false
    }
    
    @IBAction func scalePickerChanged(_ sender: UISegmentedControl)
    {
        if(scalePicker.selectedSegmentIndex == 0)
        {
            labelStack24.alpha = 1.0
            labelStack6.alpha = 0.0
            labelStack30.alpha = 0.0
        }
        if(scalePicker.selectedSegmentIndex == 1)
        {
            labelStack24.alpha = 0.0
            labelStack6.alpha = 1.0
            labelStack30.alpha = 0.0
        }
        if(scalePicker.selectedSegmentIndex == 2)
        {
            labelStack24.alpha = 0.0
            labelStack6.alpha = 0.0
            labelStack30.alpha = 1.0
        }
        generateAndLoadGraph()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(View_MatchMyTrial.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(View_MatchMyTrial.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        reliefDuration.inputView = datePicker
        NKInputView.with(trialDoseField, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(accumulatorVolumeField, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(pumpVolumeField, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)

        self.graphBorder.layer.borderColor = UIColor.lightGray.cgColor
        self.graphBorder.layer.borderWidth = 2
        self.graphBorder.layer.cornerRadius = 10
        self.displayBorder.layer.borderColor = UIColor.lightGray.cgColor
        self.displayBorder.layer.borderWidth = 2
        self.displayBorder.layer.cornerRadius = 10
        self.controlBorder.layer.borderColor = UIColor.lightGray.cgColor
        self.controlBorder.layer.borderWidth = 2
        self.controlBorder.layer.cornerRadius = 10
        self.matchTrialButton.layer.cornerRadius = 10
        self.matchTrialButton.layer.borderWidth = 2
        self.matchTrialButton.layer.borderColor = UIColor.white.cgColor
        self.advancedSettingsOpenButton.layer.borderColor = UIColor.lightGray.cgColor
        self.advancedSettingsOpenButton.layer.borderWidth = 2
        self.advancedSettingsOpenButton.layer.cornerRadius = 5
        self.advancedSettingsView.layer.borderWidth = 2
        self.advancedSettingsView.layer.cornerRadius = 10
        self.advancedSettingsView.layer.borderColor = UIColor.lightGray.cgColor
        
        let toolBar = UIToolbar().ToolbarPicker(mySelect: #selector(View_PeriodicFlow.dismissPicker))
        reliefDuration.inputAccessoryView = toolBar
    }

    func dismissPicker()
    {
        activateInputs()
        view.endEditing(true)
        let components = Calendar.current.dateComponents([.hour, .minute], from: datePicker.date)
        let hour = Float(components.hour!)
        let minute = Float(components.minute!)
        reliefDuration.text = "\(Int(hour))" + " hr " + "\(Int(minute))" + " min"
        selectedHour = Int(hour)
        selectedMinute = Int(minute)
    }
    
    lazy var datePicker: UIDatePicker =
        {
            let picker = UIDatePicker()
            picker.datePickerMode = .countDownTimer
            return picker
    }()
    
    
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
    
    weak var shapeLayer: CAShapeLayer?

    func generateAndLoadGraph()
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
        // let xShift = Float(((startHour + (startMinute/Float(60))) / 24))*graphWidth
        var bolNum = round(1440 / Float((selectedHour * 60) + (selectedMinute)))
        if(bolNum > 24) { bolNum = Float(24) }
        gBolNum = Int(bolNum)
        let cycWidth = graphWidth / bolNum
        
        var xCoord = Float(0)
        var yCoord = Float(0)
        let durTotal = Float(30)
        
        // let pumpConText = pumpConcentration.text!
        // let pumpConFloat = (pumpConText as NSString).floatValue
        let pumpConFloat = defPumpCon
        // let flowRate = bolusRate / pumpConFloat
        // let bolHeight = (bolusRate / maxBolusRate) * graphHeight
        let bolHeight = (accumVol / Float(0.007)) * graphHeight
        let bolWidth = (durTotal / (60*24)) * graphWidth
        let basWidth = cycWidth - bolWidth
        
        let trialDoseText = trialDoseField.text!
        let bolusDose = (trialDoseText as NSString).floatValue
        
        let bolPerPeriod = (bolusDose / pumpConFloat) / accumVol
        let distBetweenBol = ((durTotal / bolPerPeriod) / (24*60)) * graphWidth    //in coordinate points
        
        //ok to use cartesian coordinates, will be shifted when assigning points to path
        var coordArray = [[Float]]()
        var c = 0
        var bolCounter = 0
        // xCoord += xShift
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
}
