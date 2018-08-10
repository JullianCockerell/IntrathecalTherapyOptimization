//
//  View_EntryPage.swift
//  IntrathecalTherapyOptimization
//
//  Created by Jullian Cockerell on 8/10/18.
//  Copyright © 2018 RedRoosterDevelopment. All rights reserved.
//

import UIKit

class View_EntryPage: UIViewController {
    @IBOutlet weak var entryButton: UIButton!

    
    override func viewWillAppear(_ animated: Bool) {
        entryButton.backgroundColor = .clear
        entryButton.layer.cornerRadius = 20
        entryButton.layer.borderWidth = 5
        entryButton.layer.borderColor = UIColor.white.cgColor
        entryButton.layer.backgroundColor = UIColor.white.cgColor
        entryButton.layer.opacity = 0.22
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
