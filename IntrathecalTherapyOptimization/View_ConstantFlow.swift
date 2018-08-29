//
//  View_ConstantFlow.swift
//  IntrathecalTherapyOptimization
//
//  Created by Jullian Cockerell on 8/1/18.
//  Copyright © 2018 RedRoosterDevelopment. All rights reserved.
//

import UIKit

class View_ConstantFlow: UIViewController {

    
    @IBOutlet weak var pumpRateTextField: UITextField!
    var unitLabel = "mg"
    var roundValue = 3
    var mgMode = true
    var accumVol = Float(0.0025)
    var textHolder = "Not Set"
    var attributingText = false
    
    // Defaults: Dose, Concentration, Accumulator Volume, Maximum Dose
    // index 0 for mg, index 1 for mcg
    let defAccumVol = Float(0.0025)
    let defDose = [Float(1.0), Float(40.0)]
    let defConcentration = [Float(8.0), Float(350.0)]
    let defDoseMax = [Float(5), Float(300)]

    @IBOutlet weak var graphImage: UIImageView!
    @IBOutlet weak var doseSlider: UISlider!
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
        }
        else if(!mgMode)
        {
            unitLabel = "mg"
            mgMode = true
            doseSlider.maximumValue = defDoseMax[0]
            doseSlider.value = defDose[0]
            pumpConcentration.text = "\(defConcentration[0])"
            doseInputField.text = "\(defDose[0])"
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
    
    @IBAction func pumpConcentrationSelected(_ sender: AllowedCharsTextField)
    {
        textHolder = pumpConcentration.text!
        perform(#selector(selectPumpConcentration), with: nil, afterDelay: 0.01)
    }
    
    func selectPumpConcentration() -> Void
    {
        pumpConcentration.selectAll(nil)
    }
    
    @IBAction func pumpConcentrationChanged(_ sender: AllowedCharsTextField)
    {
        var inputText = pumpConcentration.text!
        if (inputText == "")
        {
            if (mgMode)
            {
                inputText = "\(defConcentration[0])"
            }
            else
            {
                inputText = "\(defConcentration[1])"
            }
        }
        let inputPrefix = roundValue(inputText: inputText, roundTo: 2)
        pumpConcentration.text = inputPrefix
        updateUI()
    }
    

    @IBAction func doseInputFieldSelected(_ sender: AllowedCharsTextField)
    {
        textHolder = doseInputField.text!
        perform(#selector(selectDoseInputField), with: nil, afterDelay: 0.01)
    }
    
    func selectDoseInputField() -> Void
    {
        doseInputField.selectAll(nil)
    }
    
    @IBAction func doseInputFieldChanged(_ sender: AllowedCharsTextField)
    {
        
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
            pumpRateTextField.text = "1 V.A. every " + timeBetween + " minutes"
        }
        var dosePerClickVal = String(pumpConFloat * accumVol)
        dosePerClickVal = roundValue(inputText: dosePerClickVal, roundTo: 2)
        dosePerClick.text = dosePerClickVal + " " + unitLabel
        doseSliderLabel.text = unitLabel
        doseInputField.text = inputPrefix
        pumpConcentrationLabel.text = unitLabel + "/ml"
        let pumpConText = pumpConcentration.text
        let pumpConRound = roundValue(inputText: pumpConText!, roundTo: 2)
        pumpConcentration.text = pumpConRound
        generateAndLoadGraph()
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(View_ConstantFlow.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(View_ConstantFlow.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        self.borderImage.layer.borderColor = UIColor.lightGray.cgColor
        self.borderImage.layer.borderWidth = 2
        self.borderImage.layer.cornerRadius = 10
        self.graphStyle.layer.borderWidth = 2
        self.graphStyle.layer.cornerRadius = 10
        self.graphStyle.layer.borderColor = UIColor.lightGray.cgColor
        
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
        //assign base constants
        let path = UIBezierPath()
        var xCoord = Float(0)
        var yCoord = Float(0)
        let totalDose = doseSlider.value
        let pumpCon = pumpConcentration.text!
        let pumpConFloat = (pumpCon as NSString).floatValue
        var bolNum = ((totalDose / pumpConFloat) / defAccumVol)
        let bolHeight = 0.3 * graphHeight
        let bolSpacing = graphWidth / bolNum
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
            while (c < Int(bolNum))
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
