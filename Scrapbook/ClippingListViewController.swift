//
//  ClippingListViewController.swift
//  Scrapbook
//
//  Created by Benjamin Johnson on 26/04/2016.
//  Copyright © 2016 Benjamin Johnson. All rights reserved.
//

import UIKit

class ClippingListViewController: UITableViewController, UINavigationControllerDelegate {

    var scrapbook: Scrapbook!
    
    var collection: Collection? {
        didSet {
            clippings = collection?.clippings.array as? [Clipping] ?? []
        }
    }
    
    var clippings: [Clipping] = []
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.toolbarHidden = false;
        title = collection?.name ?? "All Clippings"
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Setup Search Controller
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
       // searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar

        definesPresentationContext = true
        
    }
    
   
    @IBAction func addClipping(sender: UIBarButtonItem) {
        
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .PhotoLibrary
        imagePickerController.delegate = self
        
        let popOverController = imagePickerController.popoverPresentationController
        popOverController?.barButtonItem = sender
        imagePickerController.modalPresentationStyle = UIModalPresentationStyle.Popover
        
        self.presentViewController(imagePickerController, animated: true, completion: nil)
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
        return clippings.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let clipping = clippings[indexPath.row]
        
        cell.textLabel?.text = clipping.notes
        cell.imageView?.image = clipping.image

        return cell
    }
 
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            print(indexPath.row)
            // Delete the row from the data source
            scrapbook.deleteClipping(clippings[indexPath.row])
            clippings.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
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
            let destinationViewController = segue.destinationViewController as! ClippingDetailViewController
            destinationViewController.clipping = clippings[indexPath.row]
            
        }
    }
}

extension ClippingListViewController: UISearchResultsUpdating {

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let query = searchController.searchBar.text where query.length > 0 else {
            return
        }
        
        if let collection = collection {
            clippings = scrapbook.clippingsWithText(query, collection: collection)
        } else {
            clippings = scrapbook.clippingsWithText(query)
        }
        
        tableView.reloadData()
        
    }
}

extension ClippingListViewController: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        print("Selected Photo")
        
        // Show Notes Prompt
        let newAlertViewController = UIAlertController(title: "Create a new clipping", message: nil, preferredStyle: .Alert)
        newAlertViewController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Notes"
        }
        
        let createAction = UIAlertAction(title: "Create", style: .Default) { (action) in
            let nameTextField = newAlertViewController.textFields![0] as UITextField
            
            
            // Create Collection
            if let notes = nameTextField.text {
                let newClipping = self.scrapbook.createClipping(notes, image: image)
                
                if let collection = self.collection {
                    // Add to current collection
                    self.scrapbook.addClippingToCollection(collection, clipping: newClipping)
                }
                
                self.clippings = self.collection?.clippings.array as? [Clipping] ?? self.scrapbook.clippings

                // Update Collections
                let newRowPath = NSIndexPath(forRow: self.clippings.count - 1, inSection: 0)
                self.tableView.insertRowsAtIndexPaths([newRowPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
        
        newAlertViewController.addAction(createAction)
        newAlertViewController.addAction(cancelAction)
        
        self.dismissViewControllerAnimated(true) { 
            self.presentViewController(newAlertViewController, animated: true, completion: nil)
        }
        
    }
    
    
}

