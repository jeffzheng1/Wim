//
//  TableViewController.swift
//  Wim
//
//  Created by Jeff Zheng on 12/7/15.
//  Copyright © 2015 Jeff Zheng. All rights reserved.
//


import UIKit
import Parse

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var registrationDevices: AnyObject!
    var deviceIDList : [String] = []
    var deviceList : [PFObject] = []
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let query = PFQuery(className: "UserHack")
        query.fromLocalDatastore()
        query.whereKey("local", equalTo: "thisUser")
        
        do {
            let objects : [PFObject] = try query.findObjects()
            for (var i = 0; i < objects.count; i++) {
                if let id : String = objects[i]["registrationCode"] as? String {
                    self.deviceIDList.append(id)
                }
            }
            self.tableViewCallback()
        } catch {
             print(error)
        }
        self.tableView.reloadData()
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return self.deviceList.count
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : TableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        cell.cellLabel?.text = (self.deviceList[indexPath.row]["type"] as? String)! + " @ " + (self.deviceList[indexPath.row]["locationString"] as? String)!
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "DetailView" {
            let detailView = segue.destinationViewController as! DetailViewController
            detailView.device = self.deviceList[self.tableView.indexPathForCell(sender as! UITableViewCell)!.row]
        }
    }
    
    func tableViewCallback(){
        for deviceID in self.deviceIDList {
            let query = PFQuery(className:"Devices")
            do {
                let device = try query.getObjectWithId(deviceID)
                self.deviceList.append(device)
            } catch {
                print(error)
            }
        }
    }
}

