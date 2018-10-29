//
//  View_MatchMyTrial.swift
//  IntrathecalTherapyOptimization
//
//  Created by Jullian Cockerell on 9/5/18.
//  Copyright © 2018 RedRoosterDevelopment. All rights reserved.
//

import UIKit

class View_MatchMyTrial: UIViewController, UITextFieldDelegate
{
    let defPumpCon = Float(10)
    let defAccumVol = Float(0.0025)

    var textHolder = ""
    var selectedHour = 2
    var selectedMinute = 0
    var mgMode = true
    var unitLabel = "mg"
    var gBolNum = 0
    var pumpVolume = Float(20)
    var accumVol = Float(0.0025)
    var concentrationValue = Float(10.00)
    var updateLock = true
    var concentrationCatch = false
    var yMax = Float(0.07)
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var graphImage: UIImageView!
    @IBOutlet weak var graphImageTop: UIImageView!
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
    @IBOutlet weak var doseGraphLabel: UILabel!
    
    @IBOutlet weak var labelStack24: UIStackView!
    @IBOutlet weak var labelStack30: UIStackView!
    @IBOutlet weak var labelStack6: UIStackView!
    
    @IBOutlet weak var graphBorder: UIView!
    @IBOutlet weak var graphBorder2: UIView!
    @IBOutlet weak var controlBorder: UIView!
    @IBOutlet weak var displayBorder: UIView!
    
    @IBOutlet weak var concentrationFieldLabel: UILabel!
    @IBOutlet weak var concentrationField: UITextField!
    
    
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
    
    //Y-Axis Labels
    @IBOutlet weak var yAxis1: UILabel!
    @IBOutlet weak var yAxis2: UILabel!
    @IBOutlet weak var yAxis3: UILabel!
    @IBOutlet weak var yAxis4: UILabel!
    @IBOutlet weak var yAxis5: UILabel!
    @IBOutlet weak var yAxis6: UILabel!
    @IBOutlet weak var yAxis7: UILabel!
    

    
    
    // Advanced Settings
    @IBOutlet weak var advancedSettingsView: UIView!
    @IBOutlet weak var advancedSettingsOpenButton: UIButton!
    @IBOutlet weak var advancedSettingsCloseButton: UIButton!
    @IBOutlet weak var accumulatorVolumeField: AllowedCharsTextField!
    @IBOutlet weak var pumpVolumeField: AllowedCharsTextField!
    @IBOutlet weak var daysUntilRefillField: AllowedCharsTextField!
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
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        scrollView.setContentOffset(CGPoint(x:0, y:313), animated: true)
        if(textField == reliefDuration)
        {
            disableInputs(currentTextField: textField)
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
        if(textField == concentrationField)
        {
            activateInputs()
            if(concentrationField.text == "")
            {
                concentrationField.text = textHolder
            }
            let concentrationFieldText = concentrationField.text!
            concentrationValue = (concentrationFieldText as NSString).floatValue
            if(concentrationCatch)
            {
                updateUI()
            }
        }
        else if(textField == accumulatorVolumeField)
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
        else if(textField == trialDoseField)
        {
            activateInputs()
            if (trialDoseField.text == "")
            {
                trialDoseField.text = textHolder
            }
        }
        else if(textField == reliefDuration)
        {
            activateInputs()
        }
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
            concentrationFieldLabel.text = unitLabel + "/ml"
            doseGraphLabel.text = "Dose (" + unitLabel + ")"
            concentrationValue = Float(300.0)
            concentrationField.text = "300.0"
            trialDoseField.text = "50.0"
            yAxis1.text = "1.0"
            yAxis2.text = "2.0"
            yAxis3.text = "3.0"
            yAxis4.text = "4.0"
            yAxis5.text = "5.0"
            yAxis6.text = "6.0"
            yAxis7.text = "7.0"
            yMax = Float(7.0)
        }
        else
        {
            mgMode = true
            unitLabel = "mg"
            totalDailyDoseLabel.text = unitLabel
            dosePerBolusLabel.text = unitLabel
            trialDoseLabel.text = unitLabel
            concentrationFieldLabel.text = unitLabel + "/ml"
            doseGraphLabel.text = "Dose (" + unitLabel + ")"
            concentrationValue = Float(10.0)
            concentrationField.text = "10.0"
            trialDoseField.text = "2.5"
            yAxis1.text = "0.01"
            yAxis2.text = "0.02"
            yAxis3.text = "0.03"
            yAxis4.text = "0.04"
            yAxis5.text = "0.05"
            yAxis6.text = "0.06"
            yAxis7.text = "0.07"
            yMax = Float(0.07)
        }
        generateAndLoadGraph()
    }
    
    @IBAction func matchTrial(_ sender: UIButton)
    {
        if(!concentrationCatch)
        {
            concentrationCatch = true
        }
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
        if(updateLock)
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
            let pumpConFloat = concentrationValue
            let totalDoseCon = (totalDose / pumpConFloat)   //in mL's
            daysUntilRefillField.text = "\(pumpVolume / totalDoseCon)" + " days"
            pumpVolumeField.text = "\(pumpVolume)"
            accumulatorVolumeField.text = "\(accumVol)"
        }
    }

    func activateInputs() -> Void
    {
        scalePicker.isUserInteractionEnabled = true
        trialDoseField.isUserInteractionEnabled = true
        reliefDuration.isUserInteractionEnabled = true
        unitSwitch.isUserInteractionEnabled = true
        matchTrialButton.isUserInteractionEnabled = true
        exitButton.isUserInteractionEnabled = true
        advancedSettingsOpenButton.isUserInteractionEnabled = true
        advancedSettingsCloseButton.isUserInteractionEnabled = true
        accumulatorVolumeField.isUserInteractionEnabled = true
        pumpVolumeField.isUserInteractionEnabled = true
        concentrationField.isUserInteractionEnabled = true
    }
    
    func disableInputs(currentTextField: UITextField) -> Void
    {
        if(currentTextField != trialDoseField){ trialDoseField.isUserInteractionEnabled = false }
        if(currentTextField != reliefDuration){ reliefDuration.isUserInteractionEnabled = false }
        if(currentTextField != accumulatorVolumeField){ accumulatorVolumeField.isUserInteractionEnabled = false }
        if(currentTextField != pumpVolumeField){ pumpVolumeField.isUserInteractionEnabled = false }
        if(currentTextField != concentrationField){ concentrationField.isUserInteractionEnabled = false }
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

        reliefDuration.inputView = datePicker
        NKInputView.with(trialDoseField, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(accumulatorVolumeField, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(pumpVolumeField, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)
        NKInputView.with(concentrationField, type: NKInputView.NKKeyboardType.decimalPad, returnKeyType: NKInputView.NKKeyboardReturnKeyType.done)

        self.graphBorder.layer.borderColor = UIColor.lightGray.cgColor
        self.graphBorder.layer.borderWidth = 2
        self.graphBorder.layer.cornerRadius = 10
        self.graphBorder2.layer.borderColor = UIColor.lightGray.cgColor
        self.graphBorder2.layer.borderWidth = 2
        self.graphBorder2.layer.cornerRadius = 10
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
    
    
    weak var shapeLayer: CAShapeLayer?
    weak var shapeLayer2: CAShapeLayer?

    func generateAndLoadGraph()
    {
        //remove old shape layer if any is present
        self.shapeLayer?.removeFromSuperlayer()
        self.shapeLayer2?.removeFromSuperlayer()
        let graphX2 = Float(graphImage.frame.origin.x)
        let graphY2 = Float(graphImage.frame.origin.y)
        let graphX = Float(graphImageTop.frame.origin.x)
        let graphY = Float(graphImageTop.frame.origin.y)
        let graphWidth = Float(graphImage.bounds.width)
        let graphHeight = Float(graphImage.bounds.height)
        
        //create path for graph to draw
        //assign base constants
        let path = UIBezierPath()
        let path2 = UIBezierPath()
        // let xShift = Float(((startHour + (startMinute/Float(60))) / 24))*graphWidth
        var bolNum = round(1440 / Float((selectedHour * 60) + (selectedMinute)))
        if(bolNum > 24) { bolNum = Float(24) }
        gBolNum = Int(bolNum)
        let cycWidth = graphWidth / bolNum
        
        var xCoord = Float(0)
        var yCoord = Float(0)
        var yCoord2 = Float(0)
        let durTotal = Float(30)
        
        // let pumpConText = pumpConcentration.text!
        // let pumpConFloat = (pumpConText as NSString).floatValue
        let pumpConFloat = concentrationValue
        // let flowRate = bolusRate / pumpConFloat
        // let bolHeight = (bolusRate / maxBolusRate) * graphHeight
        let bolHeight = ((accumVol * concentrationValue) / yMax) * graphHeight
        let bolWidth = (durTotal / (60*24)) * graphWidth
        let basWidth = cycWidth - bolWidth
        
        let trialDoseText = trialDoseField.text!
        let bolusDose = (trialDoseText as NSString).floatValue
        
        let bolPerPeriod = (bolusDose / pumpConFloat) / accumVol
        let distBetweenBol = ((durTotal / bolPerPeriod) / (24*60)) * graphWidth    //in coordinate points
        
        //ok to use cartesian coordinates, will be shifted when assigning points to path
        var coordArray = [[Float]]()
        var coordArray2 = [[Float]]()
        var c = 0
        var bolCounter = 0
        // xCoord += xShift
        var cSet: [Float] = [xCoord, yCoord]
        coordArray.append(cSet)
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
        if(zeroIndex > 0)
        {
            let endArray = Array(coordArray[0..<zeroIndex])
            let beginArray = Array(coordArray[zeroIndex..<coordArray.count])
            coordArray = beginArray + endArray
            let endArray2 = Array(coordArray2[0..<zeroIndex2])
            let beginArray2 = Array(coordArray2[zeroIndex2..<coordArray2.count])
            coordArray2 = beginArray2 + endArray2
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
                coordArray2[c][0] = coordArray2[c][0] * 4
                c += 1
            }
        }
        else if(scaling == 2)
        {
            c = 0
            while(c < coordArray.count)
            {
                coordArray[c][0] = coordArray[c][0] * 48
                coordArray2[c][0] = coordArray2[c][0] * 48
                c += 1
            }
        }
        
        //add points to path
        c = 1
        path.move(to: CGPoint(x: Int(coordArray[0][0] + graphX), y: Int(graphHeight + graphY - coordArray[0][1])))
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
        
        //create shape layer for that path
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.path = path.cgPath
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineJoin = kCALineJoinRound
        mainView.layer.addSublayer(shapeLayer)
        
        let shapeLayer2 = CAShapeLayer()
        shapeLayer2.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer2.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        shapeLayer2.lineWidth = 3
        shapeLayer2.path = path2.cgPath
        shapeLayer2.lineCap = kCALineCapRound
        shapeLayer2.lineJoin = kCALineJoinRound
        mainView.layer.addSublayer(shapeLayer2)
        
        //save shape layer to viewcontroller
        self.shapeLayer = shapeLayer
        self.shapeLayer2 = shapeLayer2
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
