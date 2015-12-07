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
    
    var registrationDevices: AnyObject!
    var deviceIDList : [String] = []
    
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
            self.registrationDevices = task.result
            for (var i = 0; i < self.registrationDevices.count; i++) {
                if let id : String = self.registrationDevices[i]["registrationCode"] as? String {
                    self.deviceIDList.append(id)
                }
            }
            self.tableViewCallback()
            return task
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableViewCallback(){
        for deviceID in self.deviceIDList {
            let query = PFQuery(className:"Devices")
            query.getObjectInBackgroundWithId(deviceID) {
                (device: PFObject?, error: NSError?) -> Void in
                if error == nil && device != nil {
                    let type : String = device!["type"] as! String
                    let status : String = device!["status"] as! String
                    let location : String = device!["locationString"] as! String
                } else {
                    print(error)
                }
            }
        }
    }
}

