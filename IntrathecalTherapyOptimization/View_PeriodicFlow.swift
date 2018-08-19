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
    @IBOutlet weak var pumpRateLabel: UITextField!
    @IBOutlet weak var totalDoseLabel: UITextField!
    @IBOutlet weak var warningImage: UIImageView!
    weak var shapeLayer: CAShapeLayer?
    var currentMinute = Float(0)
    var currentHour = Float(0)
    let globalYMargin = Float(55)
    var mgMode = true
    var unitLabel = "mg"

    @IBOutlet weak var scalePicker: UISegmentedControl!
    @IBOutlet weak var doseField: UITextField!
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
    
    @IBAction func doseFieldChanged(_ sender: UITextField)
    {
        var inputText = doseField.text!
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
            var inputInt = Int(inputFloat)
            inputInt = inputInt - (inputInt % 5)
            doseSlider.value = Float(inputInt)
            let doseInputText = "\(doseSlider.value)"
            doseField.text = roundValue(inputText: doseInputText, roundTo: 2)
        }
        else
        {
            let inputPrefix = roundValue(inputText: inputText, roundTo: 1)
            doseField.text = inputPrefix
            doseSlider.value = inputFloat
        }
        updateUI()
    }
    
    func updateUI()
    {
        let inputText = doseField.text!
        let inputFloat = (inputText as NSString).floatValue
        let inputPrefix = roundValue(inputText: inputText, roundTo: 1)
        doseSlider.value = inputFloat
        doseField.text = inputPrefix
        let totalDose = doseSlider.value * Float(intervalStepper.value)
        totalDoseLabel.text = roundValue(inputText: "\(totalDose)", roundTo: 2) + " " + unitLabel
        let components = Calendar.current.dateComponents([.hour, .minute], from: durationPicker.date)
        let durHour = Float(components.hour!)
        let durMinute = Float(components.minute!)
        let durTotal = (60*durHour) + durMinute
        let pumpRate = doseSlider.value / durTotal
        pumpRateLabel.text = roundValue(inputText: "\(pumpRate)", roundTo: 2) + " " + unitLabel + "/min"
        doseFieldLabel.text = unitLabel
        var currentHourVar = currentHour
        var timeLabel = "AM"
        if(currentHourVar > 12)
        {
            currentHourVar -= 12
            timeLabel = "PM"
        }
        startTimeField.text = "\(Int(currentHourVar))" + ":" + "\(Int(currentMinute))" + " " + timeLabel
        pumpConcentrationLabel.text = unitLabel + "/ml"
        generateAndLoadGraph(yMargin: globalYMargin, xMargin: (Float(self.view.bounds.width) - Float(graphImage.bounds.width)) / Float(2), gHeight: Float(graphImage.bounds.height))
    }
    
    
    @IBAction func unitPickerChanged(_ sender: UISwitch)
    {
        if(mgMode)
        {
            mgMode = false
            unitLabel = "mcg"
            doseSlider.maximumValue = 300
            doseSlider.value = 100
            doseField.text = "100.0"
        }
        else
        {
            mgMode = true
            unitLabel = "mg"
            doseSlider.maximumValue = 5
            doseSlider.value = 2.5
            doseField.text = "2.5"
        }
        updateUI()
    }
    
    
    @IBAction func scalePickerChanged(_ sender: UISegmentedControl)
    {
        let pickerValue = scalePicker.selectedSegmentIndex
        if(pickerValue == 0)
        {
            generateAndLoadGraph(yMargin: globalYMargin, xMargin: (Float(self.view.bounds.width) - Float(graphImage.bounds.width)) / Float(2), gHeight: Float(graphImage.bounds.height))
            UIView.animate(withDuration: 0.5, animations: {
                self.labelStack6.alpha = 0.0
                self.labelStack24.alpha = 1.0
                self.labelStack30.alpha = 0.0
            })
        }
        else if (pickerValue == 1)
        {
            generateAndLoadGraph(yMargin: globalYMargin, xMargin: (Float(self.view.bounds.width) - Float(graphImage.bounds.width)) / Float(2), gHeight: Float(graphImage.bounds.height))
            UIView.animate(withDuration: 0.5, animations: {
                self.labelStack6.alpha = 1.0
                self.labelStack24.alpha = 0.0
                self.labelStack30.alpha = 0.0
            })
        }
        else if (pickerValue == 2)
        {
            generateAndLoadGraph(yMargin: globalYMargin, xMargin: (Float(self.view.bounds.width) - Float(graphImage.bounds.width)) / Float(2), gHeight: Float(graphImage.bounds.height))
            UIView.animate(withDuration: 0.5, animations: {
                self.labelStack6.alpha = 0.0
                self.labelStack24.alpha = 0.0
                self.labelStack30.alpha = 1.0
            })
        }
    }
    
    
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        
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
            generateAndLoadGraph(yMargin: globalYMargin, xMargin: (Float(self.view.bounds.width) - Float(graphImage.bounds.width)) / Float(2), gHeight: Float(graphImage.bounds.height))
            updateUI()
        }
        
    }
    
    @IBAction func intervalStepperChanged(_ sender: UIStepper) {
        let cVal = Int(sender.value)
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

    
    
    func generateAndLoadGraph(yMargin: Float, xMargin: Float, gHeight: Float)
    {
        //remove old shape layer if any is present
        self.shapeLayer?.removeFromSuperlayer()
        
        //create path for graph to draw
        //assign base constants
        let path = UIBezierPath()
        let gWidth = Float(Float(self.view.bounds.width) - (xMargin*2))
        let xShift = Float(((currentHour + (currentMinute/Float(60))) / 24))*gWidth
        let bolNum = Float(intervalStepper.value)
        let cycWidth = gWidth / bolNum
        
        var xCoord = Float(0)
        var yCoord = Float(0)
        let components = Calendar.current.dateComponents([.hour, .minute], from: durationPicker.date)
        let durHour = Float(components.hour!)
        let durMinute = Float(components.minute!)
        let durTotal = (60*durHour) + durMinute
        
        let bolusRate = doseSlider.value / durTotal
        let pumpConText = pumpConcentration.text!
        let pumpConFloat = (pumpConText as NSString).floatValue
        let flowRate = bolusRate / pumpConFloat
        let bolHeight = (flowRate / Float(0.03)) * gHeight
        
        let bolWidth = (durTotal / (60*24)) * gWidth
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
            if (xCoord > gWidth)
            {
                cSet = [gWidth, yCoord]
                coordArray.append(cSet)
                zeroIndex = coordArray.count
                xCoord = xCoord - gWidth
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
            if (xCoord > gWidth)
            {
                cSet = [gWidth, yCoord]
                coordArray.append(cSet)
                zeroIndex = coordArray.count
                xCoord = xCoord - gWidth
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
        path.move(to: CGPoint(x: Int(coordArray[0][0] + xMargin), y: Int(gHeight + yMargin - coordArray[0][1])))
        while(c < coordArray.count)
        {
            if(coordArray[c][0] <= gWidth)
            {
                path.addLine(to: CGPoint(x: Int(coordArray[c][0] + xMargin), y: Int(gHeight + yMargin - coordArray[c][1])))
                c += 1
            }
            else
            {
                path.addLine(to: CGPoint(x: Int(gWidth + xMargin), y: Int(gHeight + yMargin - coordArray[c][1])))
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
        let date = Date()
        let calendar = Calendar.current
        currentHour = Float(calendar.component(.hour, from: date))
        currentMinute = Float(calendar.component(.minute, from: date))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let initDateTime = formatter.date(from: "2016/10/08 00:10")
        
        durationPicker.setDate(initDateTime!, animated: true)
        updateUI()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(View_ConstantFlow.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(View_ConstantFlow.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        
        
        let borderColor = UIColor.lightGray.cgColor
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    


}
