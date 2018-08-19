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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        DispatchQueue.main.asyncAfter(deadline:.now() + 2.0, execute: {
            self.performSegue(withIdentifier:"showHomePage",sender: self)
        })
    }
    
    override var shouldAutorotate: Bool
    {
        return false
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
