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
    
    let globalYMargin = Float(55)
    
    @IBOutlet weak var scalePicker: UISegmentedControl!
    
    @IBAction func unitSwitchChanged(_ sender: UISwitch)
    {
        if(mgMode)
        {
            unitLabel = "mcg"
            mgMode = false
            doseSlider.maximumValue = Float(300)
            doseSlider.value = Float(150)
            pumpConcentration.text = "120.00"
            doseInputField.text = "\(doseSlider.value)"
        }
        else if(!mgMode)
        {
            unitLabel = "mg"
            mgMode = true
            doseSlider.maximumValue = Float(10)
            doseSlider.value = Float(5)
            pumpConcentration.text = "6.00"
            doseInputField.text = "\(doseSlider.value)"
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
            doseInputField.text = "\(doseSlider.value)"
        }
        updateUI()
    }
    
    @IBAction func pumpConcentrationChanged(_ sender: UITextField)
    {
        let inputText = pumpConcentration.text!
        let inputPrefix = roundValue(inputText: inputText, roundTo: 2)
        pumpConcentration.text = inputPrefix
        updateUI()
    }
    
    @IBAction func doseInputFieldChanged(_ sender: UITextField)
    {
        let inputText = doseInputField.text!
        let inputFloat = (inputText as NSString).floatValue
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
            generateAndLoadGraph(yMargin: globalYMargin, xMargin: (Float(self.view.bounds.width) - Float(graphImage.bounds.width)) / Float(2), gHeight: Float(graphImage.bounds.height))
            UIView.animate(withDuration: 0.7, animations: {
                self.labelStack6.alpha = 0.0
                self.labelStack24.alpha = 1.0
                self.labelStack30.alpha = 0.0
            })
        }
        else if (pickerValue == 1)
        {
            generateAndLoadGraph(yMargin: globalYMargin, xMargin: (Float(self.view.bounds.width) - Float(graphImage.bounds.width)) / Float(2), gHeight: Float(graphImage.bounds.height))
            UIView.animate(withDuration: 0.7, animations: {
                self.labelStack6.alpha = 1.0
                self.labelStack24.alpha = 0.0
                self.labelStack30.alpha = 0.0
            })
        }
        else if (pickerValue == 2)
        {
            generateAndLoadGraph(yMargin: globalYMargin, xMargin: (Float(self.view.bounds.width) - Float(graphImage.bounds.width)) / Float(2), gHeight: Float(graphImage.bounds.height))
            UIView.animate(withDuration: 0.7, animations: {
                self.labelStack6.alpha = 0.0
                self.labelStack24.alpha = 0.0
                self.labelStack30.alpha = 1.0
            })
        }
        
        
        
    }
    
    weak var shapeLayer: CAShapeLayer?
    
    func updateUI() -> Void
    {
        let inputText = doseInputField.text!
        let inputFloat = (inputText as NSString).floatValue
        let inputPrefix = roundValue(inputText: inputText, roundTo: 1)
        doseSlider.value = inputFloat
        let totalDose = doseSlider.value
        let pumpCon = pumpConcentration.text!
        let pumpConFloat = (pumpCon as NSString).floatValue
        var timeBetween = String(Float(1440) / ((totalDose / pumpConFloat) / 0.002))
        timeBetween = roundValue(inputText: timeBetween, roundTo: 2)
        pumpRateTextField.text = "1 click every " + timeBetween + " minutes"
        var dosePerClickVal = String(pumpConFloat * 0.002)
        dosePerClickVal = roundValue(inputText: dosePerClickVal, roundTo: 2)
        dosePerClick.text = dosePerClickVal + " " + unitLabel
        doseSliderLabel.text = inputPrefix + " " + unitLabel
        doseInputField.text = inputPrefix
        pumpConcentrationLabel.text = unitLabel + "/ml"
        let pumpConText = pumpConcentration.text
        let pumpConRound = roundValue(inputText: pumpConText!, roundTo: 2)
        pumpConcentration.text = pumpConRound
        
        generateAndLoadGraph(yMargin: globalYMargin, xMargin: (Float(self.view.bounds.width) - Float(graphImage.bounds.width)) / Float(2), gHeight: Float(graphImage.bounds.height))
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
        self.borderImage.layer.borderColor = UIColor.white.cgColor
        self.borderImage.layer.borderWidth = 3
        self.borderImage.layer.cornerRadius = 15
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func generateAndLoadGraph(yMargin: Float, xMargin: Float, gHeight: Float)
    {
        //remove old shape layer if any is present
        self.shapeLayer?.removeFromSuperlayer()
        
        //create path for graph to draw
        //assign base constants (will be replaced by passed variables)
        let path = UIBezierPath()
        let gWidth = Float(Float(self.view.bounds.width) - (xMargin*2))
        var xCoord = Float(0)
        var yCoord = Float(0)
        let totalDose = doseSlider.value
        let pumpCon = pumpConcentration.text!
        let pumpConFloat = (pumpCon as NSString).floatValue
        var bolNum = ((totalDose / pumpConFloat) / 0.002)
        let bolHeight = 0.3 * gHeight
        let bolSpacing = gWidth / bolNum
        bolNum += 1

        
        //ok to use cartesian coordinates, will be shifted when assigning points to path
        var coordArray = [[Int]]()
        var c = 0
        var cSet: [Int] = [Int(xCoord), Int(yCoord)]
        coordArray.append(cSet)
        
        //points are calculated and added to array
        while (c < Int(bolNum))
        {
            yCoord += bolHeight
            cSet = [Int(xCoord), Int(yCoord)]
            coordArray.append(cSet)
            yCoord -= bolHeight
            cSet = [Int(xCoord), Int(yCoord)]
            coordArray.append(cSet)
            xCoord += bolSpacing
            if(xCoord > gWidth)
            {
                xCoord = gWidth
            }
            cSet = [Int(xCoord), Int(yCoord)]
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
        path.move(to: CGPoint(x: coordArray[0][0] + Int(xMargin), y: Int(gHeight + yMargin) - coordArray[0][1]))
        while(c < coordArray.count)
        {
            if(Float(coordArray[c][0]) < gWidth)
            {
                path.addLine(to: CGPoint(x: coordArray[c][0] + Int(xMargin), y: Int(gHeight + yMargin) - coordArray[c][1]))
                c += 1
            }
            else
            {
                path.addLine(to: CGPoint(x: Int(gWidth) + Int(xMargin), y: Int(gHeight + yMargin) - coordArray[c][1]))
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




}
