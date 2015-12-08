//
//  DetailRegistrationViewController.swift
//  Wim
//
//  Created by Jeff Zheng on 12/5/15.
//  Copyright © 2015 Jeff Zheng. All rights reserved.
//

import UIKit
import Parse

class DetailRegistrationViewController: UIViewController {
    
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveRegistration() {
        let device = PFObject(className:"Devices")
        device["type"] = typeTextField.text
        device["locationString"] = locationTextField.text
        device["description"] = descriptionTextField.text
        device["status"] = "Off"
        device.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("Success")
            } else {
                print("Failure")
            }
        }
    }
    
}
