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

    @IBOutlet weak var pageSelection: UISegmentedControl!
    @IBOutlet weak var overviewView: UIView!
    @IBOutlet weak var constantView: UIView!
    @IBOutlet weak var multirateView: UIView!
    @IBOutlet weak var periodicView: UIView!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
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

}
