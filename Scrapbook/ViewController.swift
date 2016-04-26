//
//  ViewController.swift
//  Scrapbook
//
//  Created by Ben Johnson on 18/04/2016.
//  Copyright © 2016 Benjamin Johnson. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    var managedObjectContext: NSManagedObjectContext!
    
    func testDatabase() {
        let scrapbook = Scrapbook(managedObjectContext: managedObjectContext);
        let collectionA = scrapbook.createCollectionWithName("A")
        scrapbook.createCollectionWithName("B")
        
        // Create Clipping
        let clipping1 = scrapbook.createClipping("1 foo", imageURL: "")
        let clipping2 = scrapbook.createClipping("2 foo", imageURL: "")
        scrapbook.createClipping("3 bar", imageURL: "")
        
        print("COLLECTIONS")
        let collections = scrapbook.collections
        collections.forEach({ (collection) in
            print(collection.name)
        })
        
        for clipping in scrapbook.clippings {
            print("Name: \(clipping.notes) ImageURL: \(clipping.imageURL) Create at: \(clipping.createdAt)")
        }
        
        scrapbook.addClippingToCollection(collectionA, clipping: clipping1)
        scrapbook.addClippingToCollection(collectionA, clipping: clipping2)
        
        print("CLIPPINGS IN CollectionA")
        for clipping in collectionA.clippings {
            print("Name: \(clipping.notes) ImageURL: \(clipping.imageURL) Create at: \(clipping.createdAt)")
        }
        
        scrapbook.deleteClipping(clipping1)
        print("CLIPPINGS IN CollectionA")
        for clipping in collectionA.clippings {
            print("Name: \(clipping.notes) ImageURL: \(clipping.imageURL) Create at: \(clipping.createdAt)")
        }
        
        print("All Clippings")
        for clipping in scrapbook.clippings {
            print("Name: \(clipping.notes) ImageURL: \(clipping.imageURL) Create at: \(clipping.createdAt)")
        }
        
        print("Search Results for bar")
        for clipping in scrapbook.clippingsWithText("bar") {
            print("Name: \(clipping.notes) ImageURL: \(clipping.imageURL) Create at: \(clipping.createdAt)")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        testDatabase()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

