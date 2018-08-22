//
//  ToolbarPicker.swift
//  IntrathecalTherapyOptimization
//
//  Created by Jullian Cockerell on 8/21/18.
//  Copyright © 2018 RedRoosterDevelopment. All rights reserved.
//

import UIKit

extension UIToolbar
{
    func ToolbarPicker(mySelect : Selector) -> UIToolbar
    {
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
}
