//
//  View_PeriodicFlow.swift
//  IntrathecalTherapyOptimization
//
//  Created by Jullian Cockerell on 7/31/18.
//  Copyright © 2018 RedRoosterDevelopment. All rights reserved.
//

import UIKit

class View_PeriodicFlow: UIViewController {

    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var doseSlider: UISlider!
    @IBOutlet weak var doseSliderLabel: UILabel!
    @IBOutlet weak var intervalStepper: UIStepper!
    @IBOutlet weak var intervalStepperLabel: UILabel!
    @IBOutlet weak var durationPicker: UIDatePicker!
    @IBOutlet weak var graphImage: UIImageView!
    @IBOutlet weak var pumpRateLabel: UITextField!
    @IBOutlet weak var totalDoseLabel: UITextField!

    
    weak var shapeLayer: CAShapeLayer?
    var currentMinute = Float(0)
    var currentHour = Float(0)
    let globalYMargin = Float(55)
    
    override func viewDidAppear(_ animated: Bool)
    {
        let date = Date()
        let calendar = Calendar.current
        currentHour = Float(calendar.component(.hour, from: date))
        currentMinute = Float(calendar.component(.minute, from: date))
        controlView.layer.borderColor = #colorLiteral(red: 0.2017067671, green: 0.4073032141, blue: 0.4075613022, alpha: 1).cgColor
        controlView.layer.borderWidth = 1.0
        generateAndLoadGraph(yMargin: globalYMargin, xMargin: (Float(self.view.bounds.width) - Float(graphImage.bounds.width)) / Float(2), gHeight: Float(graphImage.bounds.height))
    }
    
    
    @IBAction func doseSliderChanged(_ sender: UISlider) {
        let cVal = Int(sender.value)
        doseSliderLabel.text = "\(cVal)" + " mg"
        generateAndLoadGraph(yMargin: globalYMargin, xMargin: (Float(self.view.bounds.width) - Float(graphImage.bounds.width)) / Float(2), gHeight: Float(graphImage.bounds.height))
        calculatePumpRate()
        calculateTotalDose()
    }

    @IBAction func durationPickerChanged(_ sender: UIDatePicker) {
        generateAndLoadGraph(yMargin: globalYMargin, xMargin: (Float(self.view.bounds.width) - Float(graphImage.bounds.width)) / Float(2), gHeight: Float(graphImage.bounds.height))
        calculatePumpRate()
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
        generateAndLoadGraph(yMargin: globalYMargin, xMargin: (Float(self.view.bounds.width) - Float(graphImage.bounds.width)) / Float(2), gHeight: Float(graphImage.bounds.height))
        calculateTotalDose()
    }
    
    func calculatePumpRate()
    {
        let components = Calendar.current.dateComponents([.hour, .minute], from: durationPicker.date)
        let durHour = Float(components.hour!)
        let durMinute = Float(components.minute!)
        let durTotal = (60*durHour) + durMinute
        let rate = Float(doseSlider.value) / Float(durTotal)
        pumpRateLabel.text = "\(rate)" + " mg/min"
    }
    
    func calculateTotalDose()
    {
        let totalDose = Float(doseSlider.value) * Float(intervalStepper.value)
        totalDoseLabel.text = "\(totalDose)" + " mg"
    }

    
    func generateAndLoadGraph(yMargin: Float, xMargin: Float, gHeight: Float)
    {
        //remove old shape layer if any is present
        self.shapeLayer?.removeFromSuperlayer()
        
        //create path for graph to draw
        //assign base constants (will be replaced by passed variables)
        let path = UIBezierPath()
        let gWidth = Float(Float(self.view.bounds.width) - (xMargin*2))
        let xShift = Float(((currentHour + (currentMinute/Float(60))) / 24))*gWidth
        let bolNum = Float(intervalStepper.value)
        let cycWidth = gWidth / bolNum
        let bolHeight = (Float(doseSlider.value) / 100) * gHeight
        var xCoord = Float(0)
        var yCoord = Float(0)
        let components = Calendar.current.dateComponents([.hour, .minute], from: durationPicker.date)
        let durHour = Float(components.hour!)
        let durMinute = Float(components.minute!)
        let durTotal = (60*durHour) + durMinute
        let bolWidth = (durTotal / (60*24)) * gWidth
        let basWidth = cycWidth - bolWidth
        
        //ok to use cartesian coordinates, will be shifted when assigning points to path
        var coordArray = [[Int]]()
        var c = 0
        xCoord += xShift
        var cSet: [Int] = [Int(xCoord), Int(yCoord)]
        coordArray.append(cSet)
        //stores index where beginning of graph is for later swapping
        var zeroIndex = 0
        //points are calculated and added to array
        while (c < Int(bolNum))
        {
            yCoord = yCoord + bolHeight
            cSet = [Int(xCoord), Int(yCoord)]
            coordArray.append(cSet)
            xCoord += bolWidth
            if (xCoord > gWidth)
            {
                cSet = [Int(gWidth), Int(yCoord)]
                coordArray.append(cSet)
                zeroIndex = coordArray.count
                xCoord = xCoord - gWidth
                cSet = [Int(0), Int(yCoord)]
                coordArray.append(cSet)
                cSet = [Int(xCoord), Int(yCoord)]
                coordArray.append(cSet)
                
            }
            else
            {
                cSet = [Int(xCoord), Int(yCoord)]
                coordArray.append(cSet)
            }
            yCoord = yCoord - bolHeight
            cSet = [Int(xCoord), Int(yCoord)]
            coordArray.append(cSet)
            xCoord += basWidth
            if (xCoord > gWidth)
            {
                cSet = [Int(gWidth), Int(yCoord)]
                coordArray.append(cSet)
                zeroIndex = coordArray.count
                xCoord = xCoord - gWidth
                cSet = [Int(0), Int(yCoord)]
                coordArray.append(cSet)
                cSet = [Int(xCoord), Int(yCoord)]
                coordArray.append(cSet)
                
            }
            else
            {
                cSet = [Int(xCoord), Int(yCoord)]
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
        //add points to path
        c = 1
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

    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
