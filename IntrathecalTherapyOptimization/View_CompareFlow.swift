//
//  View_CompareFlow.swift
//  IntrathecalTherapyOptimization
//
//  Created by Jullian Cockerell on 8/22/18.
//  Copyright © 2018 RedRoosterDevelopment. All rights reserved.
//

import UIKit

class View_CompareFlow: UIViewController
{
    var accumVol = Float(0.0025)
    var yLabelMax = Float(10)
    var startHour = Float(0)
    var startMinute = Float(0)
    
    //General
    @IBOutlet weak var pageSelection: UISegmentedControl!
    @IBOutlet weak var overviewView: UIView!
    @IBOutlet weak var constantView: UIView!
    @IBOutlet weak var multirateView: UIView!
    @IBOutlet weak var periodicView: UIView!
    @IBOutlet weak var graphDisplay: UIImageView!
    weak var constantShapeLayer: CAShapeLayer?
    weak var periodicShapeLayer: CAShapeLayer?
    weak var multiRateShapeLayer: CAShapeLayer?
    
    //Overview Outlets
    @IBOutlet weak var showConstantSwitch: UISwitch!
    @IBOutlet weak var constantTotalDoseField: UISwitch!
    @IBOutlet weak var constantConvertDoseButton: UIButton!
    @IBOutlet weak var showPeriodicSwitch: UISwitch!
    @IBOutlet weak var periodicTotalDoseField: UITextField!
    @IBOutlet weak var perioidicConvertDoseButton: UIButton!
    @IBOutlet weak var showMultiRateSwitch: UISwitch!
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
    @IBOutlet weak var periodicBolusDurationPicker: UIDatePicker!
    @IBOutlet weak var periodicStartTimeField: UITextField!
    @IBOutlet weak var periodicStepper: UIStepper!
    @IBOutlet weak var periodicStepperLabel: UILabel!
    
    //MultiRate Outlets
    @IBOutlet weak var multiRateDoseSlider1: UISlider!
    @IBOutlet weak var multiRateDurationPicker1: UIDatePicker!
    @IBOutlet weak var multiRateDoseInputField1: AllowedCharsTextField!
    @IBOutlet weak var multiRateDoseInputLabel1: UILabel!
    @IBOutlet weak var multiRatePumpRateField1: UITextField!
    @IBOutlet weak var multiRateDoseSlider2: UISlider!
    @IBOutlet weak var multiRateDurationPicker2: UIDatePicker!
    @IBOutlet weak var multiRateDoseInputField2: AllowedCharsTextField!
    @IBOutlet weak var multiRateDoseInputLabel2: UILabel!
    @IBOutlet weak var multiRatePumpRateField2: UITextField!
    @IBOutlet weak var multiRateDoseSlider3: UISlider!
    @IBOutlet weak var multiRateDurationPicker3: UIDatePicker!
    @IBOutlet weak var multiRateDoseInputField3: AllowedCharsTextField!
    @IBOutlet weak var multiRateDoseInputLabel3: UILabel!
    @IBOutlet weak var multiRatePumpRateField3: UITextField!
    @IBOutlet weak var multiRateDoseSlider4: UISlider!
    @IBOutlet weak var multiRateDurationPicker4: UIDatePicker!
    @IBOutlet weak var multiRateDoseInputField4: AllowedCharsTextField!
    @IBOutlet weak var multiRateDoseInputLabel4: UILabel!
    @IBOutlet weak var multiRatePumpRateField4: UILabel!
    
    
    //MultiRate Functions
    @IBAction func multiRateDoseInputField4EDE(_ sender: AllowedCharsTextField) {
    }
    @IBAction func multiRateDoseInputField4EDB(_ sender: AllowedCharsTextField) {
    }
    func multiRateDoseInputField4EDBDelayed() -> Void
    {
        
    }
    @IBAction func multiRateDurationPicker4Changed(_ sender: UIDatePicker) {
    }
    @IBAction func multiRateDoseSlider4Changed(_ sender: UISlider) {
    }
    @IBAction func multiRateDoseInputField3EDE(_ sender: AllowedCharsTextField) {
    }
    @IBAction func multiRateDoseInputField3EDB(_ sender: AllowedCharsTextField) {
    }
    func multiRateDoseInputField3EDBDelayed() -> Void{
        
    }
    @IBAction func multiRateDurationPicker3Changed(_ sender: UISlider) {
    }
    @IBAction func multiRateDoseSlider3Changed(_ sender: UISlider) {
    }
    @IBAction func multiRateDoseInputField2EDE(_ sender: AllowedCharsTextField) {
    }
    @IBAction func multiRateDoseInputField2EDB(_ sender: AllowedCharsTextField) {
    }
    func multiRateDoseInputField2EDBDelayed()
    {
        
    }
    @IBAction func multiRateDurationPicker2Changed(_ sender: UIDatePicker) {
    }
    @IBAction func multiRateDoseSlider2Changed(_ sender: UISlider) {
    }
    @IBAction func multiRateDoseInputField1EDE(_ sender: AllowedCharsTextField) {
    }
    @IBAction func multiRateDoseInputField1EDB(_ sender: AllowedCharsTextField) {
    }
    func multiRateDoseInputField1EDBDelayed() -> Void
    {
        
    }
    @IBAction func multiRateDurationPicker1Changed(_ sender: UIDatePicker) {
    }
    @IBAction func multiRateDoseSlider1Changed(_ sender: UISlider) {
    }
    
    
    //Periodic Functions
    @IBAction func periodicStartTimeFieldEDE(_ sender: UITextField) {
    }
    @IBAction func periodicStartTimeFieldEDB(_ sender: UITextField) {
    }
    @IBAction func periodicBolusDurationPickerChanged(_ sender: UIDatePicker) {
    }
    @IBAction func periodicDoseSliderChanged(_ sender: UISlider) {
    }
    @IBAction func periodicDoseInputFieldEDB(_ sender: AllowedCharsTextField) {
    }
    func periodicDoseInputFieldEDBDelayed() -> Void
    {
        
    }
    @IBAction func periodicDoseInputFieldEDE(_ sender: AllowedCharsTextField) {
    }
    @IBAction func periodicStepperChanged(_ sender: UIStepper) {
    }
    
    
    //Constant Functions
    @IBAction func constantDoseInputFieldEDE(_ sender: AllowedCharsTextField) {
    }
    @IBAction func constantDoseInputFieldEDB(_ sender: AllowedCharsTextField) {
    }
    func constantDoseInputFieldEDBDelayed() -> Void
    {
        
    }
    @IBAction func constantDoseSliderChanged(_ sender: UISlider) {
    }
    
    
    //Overview Functions
    @IBAction func masterUnitSwitchFlipped(_ sender: UISwitch) {
    }
    @IBAction func masterConcentrationFieldEDE(_ sender: UITextField) {
    }
    @IBAction func masterConcentrationFieldEDB(_ sender: UITextField) {
    }
    func masterConcentrationFieldEDBDelayed() -> Void
    {
        
    }
    @IBAction func showConstantSwitchFlipped(_ sender: UISwitch) {
    }
    @IBAction func constantConvertDoseButtonTouched(_ sender: UIButton) {
    }
    @IBAction func showPeriodicSwitchFlipped(_ sender: UISwitch) {
    }
    @IBAction func periodicConvertDoseButtonTouched(_ sender: UIButton) {
    }
    @IBAction func showMultiRateSwitchFlipped(_ sender: UISwitch) {
    }
    @IBAction func multiRateConvertDoseButtonTouched(_ sender: Any) {
    }
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
    
    
    //Master Functions
    func updateUI() -> Void
    {
        
    }
    
    func initializeUI() -> Void
    {
        
    }
    
    func genConstantGraph() -> Void
    {
        //remove old shape layer if any is present
        self.constantShapeLayer?.removeFromSuperlayer()
        let graphX = Float(graphDisplay.frame.origin.x)
        let graphY = Float(graphDisplay.frame.origin.y)
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
        shapeLayer.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.path = path.cgPath
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineJoin = kCALineJoinRound
        view.layer.addSublayer(shapeLayer)
        
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
        //let scaling = scalePicker.selectedSegmentIndex
        
        //create path for graph to draw
        let path = UIBezierPath()
        let xShift = Float(((startHour + (startMinute/Float(60))) / 24)) * graphWidth
        let bolNum = Float(periodicStepper.value)
        let cycWidth = graphWidth / bolNum
        
        var xCoord = Float(0)
        var yCoord = Float(0)
        let components = Calendar.current.dateComponents([.hour, .minute], from: periodicBolusDurationPicker.date)
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
        /*if(scaling == 0)
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
            
        }*/
        
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
        self.periodicShapeLayer = shapeLayer
    }
    
    func genMultiRateGraph() -> Void
    {
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let date = Date()
        let calendar = Calendar.current
        startHour = Float(calendar.component(.hour, from: date))
        startMinute = Float(calendar.component(.minute, from: date))

    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    

}
