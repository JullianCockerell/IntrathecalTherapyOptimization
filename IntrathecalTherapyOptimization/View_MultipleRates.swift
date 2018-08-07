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
    @IBOutlet weak var periodStepper: UIStepper!
    @IBOutlet weak var periodStepperLabel: UILabel!
    
    @IBOutlet weak var doseSlider1: UISlider!
    @IBOutlet weak var doseSlider1Label: UILabel!
    @IBOutlet weak var doseSlider2: UISlider!
    @IBOutlet weak var doseSlider2Label: UILabel!
    @IBOutlet weak var doseSlider3Label: UILabel!
    @IBOutlet weak var doseSlider3: UISlider!
    @IBOutlet weak var doseSlider4Label: UILabel!
    @IBOutlet weak var doseSlider4: UISlider!
    
    @IBOutlet weak var startPicker1: UIDatePicker!
    @IBOutlet weak var endPicker1: UIDatePicker!
    @IBOutlet weak var endPicker4: UIDatePicker!
    @IBOutlet weak var startPicker4: UIDatePicker!
    @IBOutlet weak var endPicker3: UIDatePicker!
    @IBOutlet weak var startPicker3: UIDatePicker!
    @IBOutlet weak var endPicker2: UIDatePicker!
    @IBOutlet weak var startPicker2: UIDatePicker!
    
    
    @IBOutlet weak var graphImage: UIImageView!
    @IBOutlet weak var warningImage: UIImageView!
    
    @IBOutlet weak var controlStack1: UIStackView!
    @IBOutlet weak var controlStack2: UIStackView!
    @IBOutlet weak var controlStack4: UIStackView!
    @IBOutlet weak var controlStack3: UIStackView!
    
    @IBAction func startPicker1Changed(_ sender: UIDatePicker) {
        let stepperState = Int(periodStepper.value)
        if(stepperState == 2){ endPicker2.date = startPicker1.date }
        if(stepperState == 3){ endPicker3.date = startPicker1.date }
        if(stepperState == 4){ endPicker4.date = startPicker1.date }
        if(isValid())
        {
            generateAndLoadGraph(yMargin: globalYMargin, gWidth: Float(graphImage.bounds.width), gHeight: Float(graphImage.bounds.height))
        }
        
    }
    @IBAction func endPicker1Changed(_ sender: UIDatePicker) {
        startPicker2.date = endPicker1.date
        if(isValid())
        {
            generateAndLoadGraph(yMargin: globalYMargin, gWidth: Float(graphImage.bounds.width), gHeight: Float(graphImage.bounds.height))
        }
    }
    @IBAction func startPicker2Changed(_ sender: UIDatePicker) {
        endPicker1.date = startPicker2.date
        if(isValid())
        {
            generateAndLoadGraph(yMargin: globalYMargin, gWidth: Float(graphImage.bounds.width), gHeight: Float(graphImage.bounds.height))
        }
    }
    @IBAction func endPicker2Changed(_ sender: UIDatePicker) {
        let stepperState = Int(periodStepper.value)
        if(stepperState == 2){ startPicker1.date = endPicker2.date }
        if(stepperState == 3 || stepperState == 4){ startPicker3.date = endPicker2.date }
        if(isValid())
        {
            generateAndLoadGraph(yMargin: globalYMargin, gWidth: Float(graphImage.bounds.width), gHeight: Float(graphImage.bounds.height))
        }
    }
    @IBAction func startPicker3Changed(_ sender: UIDatePicker) {
        endPicker2.date = startPicker3.date
        if(isValid())
        {
            generateAndLoadGraph(yMargin: globalYMargin, gWidth: Float(graphImage.bounds.width), gHeight: Float(graphImage.bounds.height))
        }
    }
    @IBAction func endPicker3Changed(_ sender: UIDatePicker) {
        let stepperState = periodStepper.value
        if(stepperState == 3){ startPicker1.date = endPicker3.date }
        if(stepperState == 4){ startPicker4.date = endPicker3.date }
        if(isValid())
        {
            generateAndLoadGraph(yMargin: globalYMargin, gWidth: Float(graphImage.bounds.width), gHeight: Float(graphImage.bounds.height))
        }
    }
    @IBAction func startPicker4Changed(_ sender: UIDatePicker) {
        endPicker3.date = startPicker4.date
        if(isValid())
        {
            generateAndLoadGraph(yMargin: globalYMargin, gWidth: Float(graphImage.bounds.width), gHeight: Float(graphImage.bounds.height))
        }
    }
    @IBAction func endPicker4Changed(_ sender: UIDatePicker) {
        startPicker1.date = endPicker4.date
        if(isValid())
        {
            generateAndLoadGraph(yMargin: globalYMargin, gWidth: Float(graphImage.bounds.width), gHeight: Float(graphImage.bounds.height))
        }
    }


    
    
    
    
    @IBAction func slider2Changed(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        doseSlider2Label.text = "\(currentValue)" + " mg"
        if(isValid())
        {
            generateAndLoadGraph(yMargin: globalYMargin, gWidth: Float(graphImage.bounds.width), gHeight: Float(graphImage.bounds.height))
        }
    }
    @IBAction func slider3Changed(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        doseSlider3Label.text = "\(currentValue)" + " mg"
        if(isValid())
        {
            generateAndLoadGraph(yMargin: globalYMargin, gWidth: Float(graphImage.bounds.width), gHeight: Float(graphImage.bounds.height))
        }
    }
    @IBAction func slider4Changed(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        doseSlider4Label.text = "\(currentValue)" + " mg"
        if(isValid())
        {
            generateAndLoadGraph(yMargin: globalYMargin, gWidth: Float(graphImage.bounds.width), gHeight: Float(graphImage.bounds.height))
        }
    }
    @IBAction func slider1Changed(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        doseSlider1Label.text = "\(currentValue)" + " mg"
        if(isValid())
        {
            generateAndLoadGraph(yMargin: globalYMargin, gWidth: Float(graphImage.bounds.width), gHeight: Float(graphImage.bounds.height))
        }
    }

    
    weak var shapeLayer: CAShapeLayer?
    
    @IBAction func periodStepperChanged(_ sender: UIStepper) {
        let stepperState = Int(sender.value)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        var dateVar = formatter.date(from: "00:00")
        periodStepperLabel.text = "\(stepperState)"
        
        if(stepperState == 2)
        {
            controlStack2.alpha = 1.0
            controlStack3.alpha = 0.0
            controlStack4.alpha = 0.0
            controlStack2.isUserInteractionEnabled = true
            controlStack3.isUserInteractionEnabled = false
            controlStack4.isUserInteractionEnabled = false
            dateVar = formatter.date(from: "00:00")
            startPicker1.setDate(dateVar!, animated: true)
            dateVar = formatter.date(from: "12:00")
            endPicker1.setDate(dateVar!, animated: true)
            dateVar = formatter.date(from: "12:00")
            startPicker2.setDate(dateVar!, animated: true)
            dateVar = formatter.date(from: "00:00")
            endPicker2.setDate(dateVar!, animated: true)
        }
        else if(stepperState == 3)
        {
            controlStack2.alpha = 1.0
            controlStack3.alpha = 1.0
            controlStack4.alpha = 0.0
            controlStack2.isUserInteractionEnabled = true
            controlStack3.isUserInteractionEnabled = true
            controlStack4.isUserInteractionEnabled = false
            dateVar = formatter.date(from: "00:00")
            startPicker1.setDate(dateVar!, animated: true)
            dateVar = formatter.date(from: "08:00")
            endPicker1.setDate(dateVar!, animated: true)
            dateVar = formatter.date(from: "08:00")
            startPicker2.setDate(dateVar!, animated: true)
            dateVar = formatter.date(from: "16:00")
            endPicker2.setDate(dateVar!, animated: true)
            dateVar = formatter.date(from: "16:00")
            startPicker3.setDate(dateVar!, animated: true)
            dateVar = formatter.date(from: "00:00")
            endPicker3.setDate(dateVar!, animated: true)
        }
        else if(stepperState == 4)
        {
            controlStack2.alpha = 1.0
            controlStack3.alpha = 1.0
            controlStack4.alpha = 1.0
            controlStack2.isUserInteractionEnabled = true
            controlStack3.isUserInteractionEnabled = true
            controlStack4.isUserInteractionEnabled = true
            dateVar = formatter.date(from: "00:00")
            startPicker1.setDate(dateVar!, animated: true)
            dateVar = formatter.date(from: "06:00")
            endPicker1.setDate(dateVar!, animated: true)
            dateVar = formatter.date(from: "06:00")
            startPicker2.setDate(dateVar!, animated: true)
            dateVar = formatter.date(from: "12:00")
            endPicker2.setDate(dateVar!, animated: true)
            dateVar = formatter.date(from: "12:00")
            startPicker3.setDate(dateVar!, animated: true)
            dateVar = formatter.date(from: "18:00")
            endPicker3.setDate(dateVar!, animated: true)
            dateVar = formatter.date(from: "18:00")
            startPicker4.setDate(dateVar!, animated: true)
            dateVar = formatter.date(from: "00:00")
            endPicker4.setDate(dateVar!, animated: true)
        }
        generateAndLoadGraph(yMargin: globalYMargin, gWidth: Float(graphImage.bounds.width), gHeight: Float(graphImage.bounds.height))
    }
    
    func isValid() -> Bool
    {
        var durTotal = Float(0)
        let stepperState = Int(periodStepper.value)
        if(stepperState == 2)
        {
            durTotal = calculateXDistance(startTime: startPicker1.date, endTime: endPicker1.date, gWidth: 100.00) + calculateXDistance(startTime: startPicker2.date, endTime: endPicker2.date, gWidth: 100.00)
        }
        else if (stepperState == 3)
        {
            durTotal = calculateXDistance(startTime: startPicker1.date, endTime: endPicker1.date, gWidth: 100.00) + calculateXDistance(startTime: startPicker2.date, endTime: endPicker2.date, gWidth: 100.00) + calculateXDistance(startTime: startPicker3.date, endTime: endPicker3.date, gWidth: 100.00)
        }
        else if (stepperState == 4)
        {
            durTotal = calculateXDistance(startTime: startPicker1.date, endTime: endPicker1.date, gWidth: 100.00) + calculateXDistance(startTime: startPicker2.date, endTime: endPicker2.date, gWidth: 100.00) + calculateXDistance(startTime: startPicker3.date, endTime: endPicker3.date, gWidth: 100.00) + calculateXDistance(startTime: startPicker4.date, endTime: endPicker4.date, gWidth: 100.00)
        }
        print(durTotal)
        if(durTotal > 100.00){warningImage.alpha = 1.0}
        else{warningImage.alpha = 0.0}
        return (durTotal <= 100.00)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateAndLoadGraph(yMargin: globalYMargin, gWidth: Float(graphImage.bounds.width), gHeight: Float(graphImage.bounds.height))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        yCoord = (doseSlider1.value / 100.00) * gHeight
        var cSet: [Int] = [Int(xCoord), Int(yCoord)]
        coordArray.append(cSet)
        var date1 = startPicker1.date
        var date2 = endPicker1.date
        var slider1 = doseSlider1.value
        
        while(c < stepperState)
        {
            if(c == 0){
                date1 = startPicker1.date
                date2 = endPicker1.date}
            else if(c == 1){
                date1 = startPicker2.date
                date2 = endPicker2.date}
            else if(c == 2){
                date1 = startPicker3.date
                date2 = endPicker3.date}
            else if(c == 3){
                date1 = startPicker4.date
                date2 = endPicker4.date}
            if(stepperState - c == 1){slider1 = doseSlider1.value}
            else if(c == 0){slider1 = doseSlider2.value}
            else if(c == 1){slider1 = doseSlider3.value}
            else if(c == 2){slider1 = doseSlider4.value}
            
            xCoord += calculateXDistance(startTime: date1, endTime: date2, gWidth: gWidth)
            if(xCoord > gWidth + 5)
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
            yCoord = (slider1 / 100.00) * gHeight
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
