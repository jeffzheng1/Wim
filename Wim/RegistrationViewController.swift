//
//  RegistrationViewController.swift
//  Wim
//
//  Created by Jeff Zheng on 12/5/15.
//  Copyright © 2015 Jeff Zheng. All rights reserved.
//

import UIKit
import Parse

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var registrationCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerDevice() {
        let registrationCode = registrationCodeTextField.text as String!
        let register = PFObject(className:"UserHack")
        register["local"] = "thisUser"
        register["registrationCode"] = registrationCode
        register.pinInBackground()
    }
    
}

