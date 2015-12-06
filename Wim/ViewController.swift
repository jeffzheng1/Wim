//
//  ViewController.swift
//  Wim
//
//  Created by Jeff Zheng on 12/5/15.
//  Copyright © 2015 Jeff Zheng. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    var registrationObjects: AnyObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let query = PFQuery(className: "UserHack")
        query.fromLocalDatastore()
        query.whereKey("local", equalTo: "thisUser")
        query.findObjectsInBackground().continueWithBlock {
            (task: BFTask!) -> AnyObject in
            if let error = task.error {
                print("Error: \(error)")
                return task
            }
            self.registrationObjects = task.result
            return task
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

