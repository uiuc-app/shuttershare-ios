//
//  GroupPhotosTableViewController.swift
//  shuttershare
//
//  Created by Yosub Shin on 6/12/14.
//  Copyright (c) 2014 yosubshin. All rights reserved.
//

import UIKit
//import MessageUI

class GroupPhotosTableViewController: UITableViewController, APIControllerProtocol, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet var shareButton: UIBarButtonItem
    var group: Group?
    var photos: Photo[] = []
    var apiController: APIController?

    init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    @IBAction func handleShareGroup(sender: AnyObject) {
        NSLog("Share button is clicked")
        
        if MFMessageComposeViewController.canSendText() {
            var controller: MFMessageComposeViewController = MFMessageComposeViewController()
            controller.messageComposeDelegate = self
            controller.body = "Hello"
            self.presentModalViewController(controller, animated: true)
        }
    }
    
    // #mark - MessageComposeViewControllerDelegate
    // http://www.appcoda.com/ios-programming-send-sms-text-message/
    // http://stackoverflow.com/questions/24311073/mfmailcomposeviewcontroller-in-swift
    
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        NSLog("MessageComposeViewController did finish with result \(result)")
        switch result.value {
        case MessageComposeResultCancelled.value:
            break
        case MessageComposeResultFailed.value:
            var warningAlert: UIAlertView = UIAlertView(title: "Error", message: "Failed to send SMS!", delegate: nil, cancelButtonTitle: "OK")
            warningAlert.show()
        case MessageComposeResultSent.value:
            break
        default:
            break
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.group!.name
        var groupPhotosApiController = GroupPhotosAPIController(delegate: self, withApiKey: "test_api_key_1") as GroupPhotosAPIController
        
        groupPhotosApiController.limit = 10
        groupPhotosApiController.groupId = self.group!.id
        
        self.apiController = groupPhotosApiController as APIController
        
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
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return photos.count
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell") as PhotoTableViewCell
        
        var photo = photos[indexPath!.row]
        NSLog("cell.photoView = \(cell.photoView)")

        let member = group!.getMember(photo.user_id!)
        
        let originalImage = UIImage(data: NSData(contentsOfURL: NSURL(string: "https://shuttershareapp.com/shuttershare-api/photos/\(photo.id!)?api_key=test_api_key_0&quality=thumbnail")))
        
        var maxHeight: Double = UIScreen.mainScreen().bounds.size.width
        var ratio: Double = originalImage.size.height / originalImage.size.width
        var calculatedHeight: Double = ratio * UIScreen.mainScreen().bounds.size.width
        var yPosition = 0.0
        if calculatedHeight > maxHeight {
            yPosition = (calculatedHeight - maxHeight) * -0.5
            calculatedHeight = maxHeight
        }
        
        cell.photoView = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, calculatedHeight))
        cell.photoView!.image = originalImage
        cell.addSubview(cell.photoView)

        cell.name = UILabel(frame: CGRectMake(10, calculatedHeight + 5, 120, 20))
        cell.name!.text = member?.name
        cell.name!.sizeToFit()
        cell.addSubview(cell.name)
        
        cell.city = UILabel(frame: CGRectMake(10 + cell.name!.frame.width + 5, calculatedHeight + 5, 120, 20))
        cell.city!.text = "Champaign, IL"
        cell.city!.textColor = UIColor.grayColor()
        cell.city!.font = UIFont.systemFontOfSize(cell.name!.font.pointSize - 2)
        cell.city!.sizeToFit()
        cell.addSubview(cell.city)
        
        return cell
    }
    
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        var cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath) as PhotoTableViewCell
        return cell.photoView!.bounds.size.height + 30
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
        var photoVC = segue!.destinationViewController as PhotoViewController
        var photo = photos[self.tableView.indexPathForSelectedRow().row]
        photoVC.photo = photo
        photoVC.group = group
        photoVC.image = UIImage(data: NSData(contentsOfURL: NSURL(string: "https://shuttershareapp.com/shuttershare-api/photos/\(photo.id!)?api_key=test_api_key_0")))
    }
    
    // #pragma mark - APIController Delegate

    func didReceiveAPIResults(results: NSDictionary) {
        for photo in results["photos"] as NSDictionary[] {
            photos.append(Photo(photo: photo))
        }
        self.tableView.reloadData()
    }
    
}
