//
//  ChatViewController.swift
//  2ndWeekLab
//
//  Created by Udgam Goyal on 6/21/16.
//  Copyright © 2016 Udgam Goyal. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatField: UITextField!
    var refreshControl = UIRefreshControl()
    var query = PFQuery(className:"Message_fbuJuly2016")
    var dict: [PFObject]!
    override func viewDidLoad() {
        super.viewDidLoad()
//        query.whereKey("playerName", equalTo:"Sean Plott")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    self.dict = objects
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }

        
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func onTimer() {
        chatTableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.dict.count
        
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    
        let cell = chatTableView.dequeueReusableCellWithIdentifier("chatCell", forIndexPath: indexPath) as! MessageCell
        let d = dict![indexPath.row]
        cell.messageOutput.text = d["text"] as! String
        
        return cell
    }
    
    

    @IBAction func sendMessage(sender: AnyObject) {
        
        var message = PFObject(className:"Message_fbuJuly2016")
        message["text"] = chatField.text
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print(message)
            } else {
                // There was a problem, check error.description
            }
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
