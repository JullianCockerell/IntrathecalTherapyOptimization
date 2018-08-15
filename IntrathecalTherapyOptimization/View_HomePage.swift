//
//  View_HomePage.swift
//  IntrathecalTherapyOptimization
//
//  Created by Jullian Cockerell on 8/10/18.
//  Copyright © 2018 RedRoosterDevelopment. All rights reserved.
//

import UIKit

class View_HomePage: UIViewController {

    @IBOutlet weak var squareBackground: UIImageView!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var subButton1: UIButton!
    @IBOutlet weak var subButton2: UIButton!
    @IBOutlet weak var subButton3: UIButton!
    
    @IBOutlet weak var squareBottom: NSLayoutConstraint!
    @IBOutlet weak var upButton: UIButton!

    var buttonPressed = false
    let globalRadius = CGFloat(10)

    @IBOutlet weak var flowOptions: UIStackView!
    
    @IBAction func button1Pressed(_ sender: UIButton) {
        if(buttonPressed)
        {
            self.squareBottom.constant = 0
            UIView.animate(withDuration: 0.3, animations:
            {
                self.view.layoutIfNeeded()
                self.button2.alpha = 1.0
                self.button3.alpha = 1.0
                self.flowOptions.alpha = 0.0
                self.upButton.alpha = 0.0
            })
            buttonPressed = false
        }
        else
        {
            self.squareBottom.constant = 600
            UIView.animate(withDuration: 0.3, animations:
            {
                self.view.layoutIfNeeded()
                self.button2.alpha = 0.0
                self.button3.alpha = 0.0
                self.flowOptions.alpha = 1.0
                self.upButton.alpha = 1.0
            })
            buttonPressed = true
        }
        
        
    }
    
    @IBAction func upButtonPressed(_ sender: UIButton)
    {
        self.squareBottom.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.button2.alpha = 1.0
            self.button3.alpha = 1.0
            self.flowOptions.alpha = 0.0
            self.upButton.alpha = 0.0
        })
        buttonPressed = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        squareBackground.layer.cornerRadius = globalRadius
        button1.layer.cornerRadius = globalRadius
        button2.layer.cornerRadius = globalRadius
        button3.layer.cornerRadius = globalRadius
        subButton1.layer.cornerRadius = globalRadius
        subButton2.layer.cornerRadius = globalRadius
        subButton3.layer.cornerRadius = globalRadius
        squareBackground.layer.cornerRadius = globalRadius
    }

}
