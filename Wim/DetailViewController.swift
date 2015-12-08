//
//  DetailViewController.swift
//  Wim
//
//  Created by Jeff Zheng on 12/7/15.
//  Copyright © 2015 Jeff Zheng. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: UIViewController {
    
    var device : PFObject!

    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var statusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        typeLabel.text = device["type"] as? String
        locationLabel.text = device["locationString"] as? String
        descriptionLabel.text = device["description"] as? String
        statusLabel.text = device["status"] as? String
        if statusLabel.text == "Off" {
            statusButton.setTitle("Turn On", forState: .Normal)
        } else {
            statusButton.setTitle("Turn Off", forState: .Normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeStatus(sender: AnyObject) {
        let query = PFQuery(className:"Devices")
        query.getObjectInBackgroundWithId(self.device.objectId!) {
            (device: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let device = device {
                if self.statusLabel.text == "Off" {
                    device["status"] = "On"
                    self.statusButton.setTitle("Turn Off", forState: .Normal)
                    self.statusLabel.text = "On"

                } else {
                    device["status"] = "Off"
                    self.statusButton.setTitle("Turn On", forState: .Normal)
                    self.statusLabel.text = "Off"
                }
                device.saveInBackground()
            }
        }
    }
    

}
