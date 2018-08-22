//
//  View_MultipleRates.swift
//  IntrathecalTherapyOptimization
//
//  Created by Jullian Cockerell on 8/1/18.
//  Copyright © 2018 RedRoosterDevelopment. All rights reserved.
//

import UIKit

class View_MultipleRates: UIViewController {

    var globalYMargin = Float(55)
    var mgMode = true
    var unitLabel = "mg"
    var yScale = Float(7.0)
    @IBOutlet weak var periodStepper: UIStepper!
    @IBOutlet weak var periodStepperLabel: UILabel!
    @IBOutlet weak var doseSlider1: UISlider!
    @IBOutlet weak var doseSlider2: UISlider!
    @IBOutlet weak var doseSlider3: UISlider!
    @IBOutlet weak var doseSlider4: UISlider!
    @IBOutlet weak var startPicker1: UIDatePicker!
    @IBOutlet weak var startPicker4: UIDatePicker!
    @IBOutlet weak var startPicker3: UIDatePicker!
    @IBOutlet weak var startPicker2: UIDatePicker!
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
    @IBOutlet weak var concentrationField: UITextField!
    @IBOutlet weak var concentrationFieldLabel: UILabel!
    @IBOutlet weak var doseLabel1: UILabel!
    @IBOutlet weak var doseLabel2: UILabel!
    @IBOutlet weak var doseLabel3: UILabel!
    @IBOutlet weak var doseLabel4: UILabel!
    @IBOutlet weak var controlBorder: UIView!
    @IBOutlet weak var graphBorder: UIView!
    @IBOutlet weak var miscBorder: UIView!
    
    @IBOutlet weak var controlBorderHeight: NSLayoutConstraint!
    @IBOutlet weak var miscStackTopDistance: NSLayoutConstraint!
    
    
    @IBAction func doseInput1Changed(_ sender: AllowedCharsTextField)
    {
        var inputText = doseInput1.text!
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
            inputInt = inputInt - (inputInt % 5)
            doseSlider1.value = Float(inputInt)
            let doseInputText = "\(doseSlider1.value)"
            doseInput1.text = roundValue(inputText: doseInputText, roundTo: 2)
        }
        else
        {
            let inputPrefix = roundValue(inputText: inputText, roundTo: 1)
            doseInput1.text = inputPrefix
            doseSlider1.value = inputFloat
        }
        updateUI()
    }
    
    @IBAction func doseInput2Changed(_ sender: AllowedCharsTextField)
    {
        var inputText = doseInput2.text!
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
            inputInt = inputInt - (inputInt % 5)
            doseSlider2.value = Float(inputInt)
            let doseInputText = "\(doseSlider2.value)"
            doseInput2.text = roundValue(inputText: doseInputText, roundTo: 2)
        }
        else
        {
            let inputPrefix = roundValue(inputText: inputText, roundTo: 1)
            doseInput2.text = inputPrefix
            doseSlider2.value = inputFloat
        }
        updateUI()
    }

    @IBAction func doseInput3Changed(_ sender: AllowedCharsTextField)
    {
        var inputText = doseInput3.text!
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
            inputInt = inputInt - (inputInt % 5)
            doseSlider3.value = Float(inputInt)
            let doseInputText = "\(doseSlider3.value)"
            doseInput3.text = roundValue(inputText: doseInputText, roundTo: 2)
        }
        else
        {
            let inputPrefix = roundValue(inputText: inputText, roundTo: 1)
            doseInput3.text = inputPrefix
            doseSlider3.value = inputFloat
        }
        updateUI()
    }
    
    @IBAction func doseInput4Changed(_ sender: AllowedCharsTextField)
    {
        var inputText = doseInput4.text!
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
            inputInt = inputInt - (inputInt % 5)
            doseSlider4.value = Float(inputInt)
            let doseInputText = "\(doseSlider4.value)"
            doseInput4.text = roundValue(inputText: doseInputText, roundTo: 2)
        }
        else
        {
            let inputPrefix = roundValue(inputText: inputText, roundTo: 1)
            doseInput4.text = inputPrefix
            doseSlider4.value = inputFloat
        }
        updateUI()
    }
    
    
    @IBAction func startPicker1Changed(_ sender: UIDatePicker)
    {
        if(isValid())
        {
            generateAndLoadGraph(yMargin: globalYMargin, gWidth: Float(graphImage.bounds.width), gHeight: Float(graphImage.bounds.height))
        }
        
    }

    @IBAction func startPicker2Changed(_ sender: UIDatePicker)
    {
        if(isValid())
        {
            generateAndLoadGraph(yMargin: globalYMargin, gWidth: Float(graphImage.bounds.width), gHeight: Float(graphImage.bounds.height))
        }
    }

    @IBAction func startPicker3Changed(_ sender: UIDatePicker)
    {
        if(isValid())
        {
            generateAndLoadGraph(yMargin: globalYMargin, gWidth: Float(graphImage.bounds.width), gHeight: Float(graphImage.bounds.height))
        }
    }

    @IBAction func startPicker4Changed(_ sender: UIDatePicker)
    {
        if(isValid())
        {
            generateAndLoadGraph(yMargin: globalYMargin, gWidth: Float(graphImage.bounds.width), gHeight: Float(graphImage.bounds.height))
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
    
 
    @IBAction func unitSwitchChanged(_ sender: UISwitch)
    {
        if(mgMode)
        {
            unitLabel = "mcg"
            yScale = Float(300)
            mgMode = false
            doseSlider1.maximumValue = Float(300)
            doseSlider1.value = Float(40)
            concentrationField.text = "350.00"
            doseInput1.text = "\(doseSlider1.value)"
            doseSlider2.maximumValue = Float(300)
            doseSlider2.value = Float(40)
            doseInput2.text = "\(doseSlider1.value)"
            doseSlider3.maximumValue = Float(300)
            doseSlider3.value = Float(40)
            doseInput3.text = "\(doseSlider1.value)"
            doseSlider4.maximumValue = Float(300)
            doseSlider4.value = Float(40)
            doseInput4.text = "\(doseSlider1.value)"
        }
        else if(!mgMode)
        {
            unitLabel = "mg"
            yScale = Float(7.0)
            mgMode = true
            doseSlider1.maximumValue = Float(5)
            doseSlider1.value = Float(1)
            concentrationField.text = "20.00"
            doseInput1.text = "\(doseSlider1.value)"
            doseSlider2.maximumValue = Float(5)
            doseSlider2.value = Float(2)
            doseInput2.text = "\(doseSlider2.value)"
            doseSlider3.maximumValue = Float(5)
            doseSlider3.value = Float(3)
            doseInput3.text = "\(doseSlider3.value)"
            doseSlider4.maximumValue = Float(5)
            doseSlider4.value = Float(4)
            doseInput4.text = "\(doseSlider4.value)"
        }
        updateUI()
    }
    
    
    weak var shapeLayer: CAShapeLayer?
    
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
            dateVar = formatter.date(from: "00:00")
            startPicker1.setDate(dateVar!, animated: true)
            dateVar = formatter.date(from: "12:00")
            startPicker2.setDate(dateVar!, animated: true)
            self.controlBorderHeight.constant = 180
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
            dateVar = formatter.date(from: "00:00")
            startPicker1.setDate(dateVar!, animated: true)
            dateVar = formatter.date(from: "08:00")
            startPicker2.setDate(dateVar!, animated: true)
            dateVar = formatter.date(from: "16:00")
            startPicker3.setDate(dateVar!, animated: true)
            self.controlBorderHeight.constant = 269
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
            dateVar = formatter.date(from: "00:00")
            startPicker1.setDate(dateVar!, animated: true)
            dateVar = formatter.date(from: "06:00")
            startPicker2.setDate(dateVar!, animated: true)
            dateVar = formatter.date(from: "12:00")
            startPicker3.setDate(dateVar!, animated: true)
            dateVar = formatter.date(from: "18:00")
            startPicker4.setDate(dateVar!, animated: true)
            self.controlBorderHeight.constant = 358
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
            durTotal = calculateXDistance(startTime: startPicker1.date, endTime: startPicker2.date, gWidth: 100.00) + calculateXDistance(startTime: startPicker2.date, endTime: startPicker1.date, gWidth: 100.00)
        }
        else if (stepperState == 3)
        {
            durTotal = calculateXDistance(startTime: startPicker1.date, endTime: startPicker2.date, gWidth: 100.00) + calculateXDistance(startTime: startPicker2.date, endTime: startPicker3.date, gWidth: 100.00) + calculateXDistance(startTime: startPicker3.date, endTime: startPicker1.date, gWidth: 100.00)
        }
        else if (stepperState == 4)
        {
            durTotal = calculateXDistance(startTime: startPicker1.date, endTime: startPicker2.date, gWidth: 100.00) + calculateXDistance(startTime: startPicker2.date, endTime: startPicker3.date, gWidth: 100.00) + calculateXDistance(startTime: startPicker3.date, endTime: startPicker4.date, gWidth: 100.00) + calculateXDistance(startTime: startPicker4.date, endTime: startPicker1.date, gWidth: 100.00)
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
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(View_ConstantFlow.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(View_ConstantFlow.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        miscStackTopDistance.constant = 30
        controlStack3.alpha = 0.0
        controlStack4.alpha = 0.0
        
        self.graphBorder.layer.borderWidth = 2
        self.graphBorder.layer.cornerRadius = 10
        self.graphBorder.layer.borderColor = UIColor.lightGray.cgColor
        self.controlBorder.layer.borderWidth = 2
        self.controlBorder.layer.cornerRadius = 10
        self.controlBorder.layer.borderColor = UIColor.lightGray.cgColor
        self.miscBorder.layer.borderWidth = 2
        self.miscBorder.layer.cornerRadius = 10
        self.miscBorder.layer.borderColor = UIColor.lightGray.cgColor
        
        self.startPicker1.layer.borderColor = UIColor.lightGray.cgColor
        self.startPicker1.layer.borderWidth = 2.0
        self.startPicker1.layer.cornerRadius = 5
        self.startPicker1.setValue(UIColor.white, forKeyPath: "textColor")
        self.startPicker2.layer.borderColor = UIColor.lightGray.cgColor
        self.startPicker2.layer.borderWidth = 2.0
        self.startPicker2.layer.cornerRadius = 5
        self.startPicker2.setValue(UIColor.white, forKeyPath: "textColor")
        self.startPicker3.layer.borderColor = UIColor.lightGray.cgColor
        self.startPicker3.layer.borderWidth = 2.0
        self.startPicker3.layer.cornerRadius = 5
        self.startPicker3.setValue(UIColor.white, forKeyPath: "textColor")
        self.startPicker4.layer.borderColor = UIColor.lightGray.cgColor
        self.startPicker4.layer.borderWidth = 2.0
        self.startPicker4.layer.cornerRadius = 5
        self.startPicker4.setValue(UIColor.white, forKeyPath: "textColor")
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
    
    @objc func keyboardWillShow(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        {
            if self.view.frame.origin.y == 0
            {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        {
            if self.view.frame.origin.y != 0
            {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
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
    
    func updateUI() -> Void
    {
        var totalDose = doseSlider1.value + doseSlider2.value
        concentrationFieldLabel.text = unitLabel
        doseLabel1.text = unitLabel
        doseLabel2.text = unitLabel
        doseLabel3.text = unitLabel
        doseLabel4.text = unitLabel
        let pumpConText = concentrationField.text!
        let pumpConFloat = (pumpConText as NSString).floatValue
        let bolusGrams = 0.002 * pumpConFloat
        let periods = Int(periodStepper.value)
        let minuteArray = calcMinuteArray(stepperState: periods)
        let pumpRate1 = Float(minuteArray[0]) / (doseSlider1.value / bolusGrams)
        let pumpRate1Round = roundValue(inputText: "\(pumpRate1)", roundTo: 1)
        rate1.text = "1 click every \(pumpRate1Round) min"
        let pumpRate2 = Float(minuteArray[1]) / (doseSlider2.value / bolusGrams)
        let pumpRate2Round = roundValue(inputText: "\(pumpRate2)", roundTo: 1)
        rate2.text = "1 click every \(pumpRate2Round) min"
        if(periods > 2)
        {
            let pumpRate3 = Float(minuteArray[2]) / (doseSlider3.value / bolusGrams)
            let pumpRate3Round = roundValue(inputText: "\(pumpRate3)", roundTo: 1)
            rate3.text = "1 click every \(pumpRate3Round) min"
            totalDose += doseSlider3.value
        }
        if(periods > 3)
        {
            let pumpRate4 = Float(minuteArray[3]) / (doseSlider4.value / bolusGrams)
            let pumpRate4Round = roundValue(inputText: "\(pumpRate4)", roundTo: 1)
            rate4.text = "1 click every \(pumpRate4Round) min"
            totalDose += doseSlider4.value
        }
        totalDoseField.text = "\(totalDose)" + " " + unitLabel
        generateAndLoadGraph(yMargin: globalYMargin, gWidth: Float(graphImage.bounds.width), gHeight: Float(graphImage.bounds.height))
    }
    
    func calcMinuteArray(stepperState: Int) -> [Int]
    {
        var minuteArray = [Int]()
        let component1 = Calendar.current.dateComponents([.hour, .minute], from: startPicker1.date)
        let time1 = Int((Float(component1.hour!) * 60) + Float(component1.minute!))
        let component2 = Calendar.current.dateComponents([.hour, .minute], from: startPicker2.date)
        let time2 = Int((Float(component2.hour!) * 60) + Float(component2.minute!))
        var time3 = 0
        var time4 = 0
        if(stepperState > 2)
        {
            let component3 = Calendar.current.dateComponents([.hour, .minute], from: startPicker3.date)
            time3 = Int((Float(component3.hour!) * 60) + Float(component3.minute!))
        }
        if(stepperState > 3)
        {
            let component4 = Calendar.current.dateComponents([.hour, .minute], from: startPicker4.date)
            time4 = Int((Float(component4.hour!) * 60) + Float(component4.minute!))
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
    
    func generateAndLoadGraph(yMargin: Float, gWidth: Float, gHeight: Float)
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
        
        //stores index where beginning of graph is for later swapping
        var zeroIndex = 0
        
        //points are calculated and added to array
        var components = Calendar.current.dateComponents([.hour, .minute], from: startPicker1.date)
        xCoord += ((Float(components.hour!) / 24.00) + (Float(components.minute!) / (24.00 * 60.00))) * gWidth
        yCoord = (doseSlider1.value / yScale) * gHeight
        var cSet: [Int] = [Int(xCoord), Int(yCoord)]
        coordArray.append(cSet)
        var date1 = startPicker1.date
        var date2 = startPicker1.date
        var sliderVal = doseSlider1.value
        var prevSliderVal = doseSlider2.value
        while(c < stepperState)
        {
            if(c == 0)
            {
                date1 = startPicker1.date
                date2 = startPicker2.date
            }
            else if(c == 1)
            {
                date1 = startPicker2.date
                date2 = startPicker3.date
            }
            else if(c == 2)
            {
                date1 = startPicker3.date
                date2 = startPicker4.date
            }
            else if(c == 3)
            {
                date1 = startPicker4.date
                date2 = startPicker1.date
            }
            
            if(stepperState - c == 1)
            {
                sliderVal = doseSlider1.value
                if(stepperState == 2){ prevSliderVal = doseSlider2.value }
                if(stepperState == 3){ prevSliderVal = doseSlider3.value }
                if(stepperState == 4){ prevSliderVal = doseSlider4.value }
                date2 = startPicker1.date
            }
            else if(c == 0){ sliderVal = doseSlider2.value }
            else if(c == 1){ sliderVal = doseSlider3.value }
            else if(c == 2){ sliderVal = doseSlider4.value }
            
            xCoord += calculateXDistance(startTime: date1, endTime: date2, gWidth: gWidth)
            if(xCoord == gWidth)
            {
                if(sliderVal < prevSliderVal)
                {
                    cSet = [Int(xCoord), Int(yCoord)]
                    coordArray.append(cSet)
                }
                else
                {
                    let xDiff = xCoord - gWidth
                    xCoord = gWidth
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
            else if(xCoord > gWidth)
            {

                let xDiff = xCoord - gWidth
                xCoord = gWidth
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
            yCoord = (sliderVal / yScale) * gHeight
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
        let xMargin = (self.view.bounds.width - graphImage.bounds.width) / 2.00
        path.move(to: CGPoint(x: coordArray[0][0] + Int(xMargin), y: Int(gHeight + yMargin) - coordArray[0][1]))
        while(c < coordArray.count)
        {
            path.addLine(to: CGPoint(x: coordArray[c][0] + Int(xMargin), y: Int(gHeight + yMargin) - coordArray[c][1]))
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
        view.layer.addSublayer(shapeLayer)
        
        
        //save shape layer to viewcontroller
        self.shapeLayer = shapeLayer
        
    }
    
    //takes two date objects and the width and calculates length of the multi-rate period in cartesian coordinates
    func calculateXDistance(startTime: Date, endTime: Date, gWidth: Float) -> Float
    {
        var components = Calendar.current.dateComponents([.hour, .minute], from: startTime)
        let sTime = (Float(components.hour!) / 24.00) + (Float(components.minute!) / (24.00 * 60.00))
        components = Calendar.current.dateComponents([.hour, .minute], from: endTime)
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
