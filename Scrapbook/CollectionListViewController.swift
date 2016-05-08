//
//  CollectionListViewController.swift
//  Scrapbook
//
//  Created by Benjamin Johnson on 26/04/2016.
//  Copyright © 2016 Benjamin Johnson. All rights reserved.
//

import UIKit

class CollectionListViewController: UITableViewController {
    
    var scrapbook: Scrapbook!
    var collections: [Collection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem()
        
        let managedObjectContext  = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        scrapbook = Scrapbook(managedObjectContext: managedObjectContext)
        if scrapbook.collections.count == 0 {
            scrapbook.populateWithSampleData()
        }
        
        collections = scrapbook.collections
    
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Delete the row from the data source
            scrapbook.deleteCollection(collections[indexPath.row])
            collections.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scrapbook.collections.count + 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        if indexPath.row == 0 {
            // All Clippings cell
            cell.textLabel?.text = "All Clippings"
        } else {
            let collection = collections[indexPath.row - 1]
            cell.textLabel?.text = collection.name
        }


        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row == 0 {
            return false
        }
        
        return true
    }
    
    @IBAction func addTapped(sender: UIBarButtonItem) {
        
        // Create Collection
        let newAlertViewController = UIAlertController(title: "Create a new collection", message: nil, preferredStyle: .Alert)
        newAlertViewController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Collection Name"
        }
        
        let createAction = UIAlertAction(title: "Create", style: .Default) { (action) in
            let nameTextField = newAlertViewController.textFields![0] as UITextField

            
           // Create Collection
            if let name = nameTextField.text {
                self.scrapbook.createCollectionWithName(name)
                
                // Update Collections
                self.collections = self.scrapbook.collections
                let newRowPath = NSIndexPath(forRow: self.collections.count, inSection: 0)
                self.tableView.insertRowsAtIndexPaths([newRowPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }

        newAlertViewController.addAction(createAction)
        newAlertViewController.addAction(cancelAction)
        
        presentViewController(newAlertViewController, animated: true, completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
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
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDetail" {
            let indexPath = tableView.indexPathForSelectedRow!
            let destinationViewController = segue.destinationViewController as! ClippingListViewController
            destinationViewController.scrapbook = scrapbook

            if indexPath.row == 0 {
                destinationViewController.clippings = scrapbook.clippings
                
            } else {
                destinationViewController.collection = collections[indexPath.row - 1]
            }
           
            
            
        }
        
    }
    

}
