//
//  GroupsTableViewController.swift
//  shuttershare
//
//  Created by Yosub Shin on 6/11/14.
//  Copyright (c) 2014 yosubshin. All rights reserved.
//

import UIKit

class GroupsTableViewController: UITableViewController, APIControllerProtocol {
    
    var groups: Group[] = []
    var apiController: APIController?

    init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.apiController = GroupsAPIController(delegate: self, withApiKey: "test_api_key_1")
        self.apiController!.executeRequest()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        var cell: UITableViewCell = tableView!.dequeueReusableCellWithIdentifier("GroupCell") as UITableViewCell
        
        let group = self.groups[indexPath!.row]
        cell.text = group.name
        cell.detailTextLabel.text = group.pass_phrase
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView?, canEditRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView?, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath?) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView?, moveRowAtIndexPath fromIndexPath: NSIndexPath?, toIndexPath: NSIndexPath?) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView?, canMoveRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        if segue!.destinationViewController is GroupPhotosTableViewController {
            NSLog("Group Photos Table View Controller is being segued")
            var destViewController = segue!.destinationViewController as GroupPhotosTableViewController
            destViewController.group = self.groups[self.tableView.indexPathForSelectedRow().row]
        } else {
            NSLog("Camera View Controller is being segued")
        }
    }
    
    // #pragma mark - APIController Delegate
    
    func didReceiveAPIResults(results: NSDictionary) {
        for group in results["groups"] as NSDictionary[] {
            groups.append(Group(group: group))
        }
        self.tableView.reloadData()
    }

}
