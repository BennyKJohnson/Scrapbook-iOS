//
//  Scrapbook.swift
//  Scrapbook
//
//  Created by Ben Johnson on 18/04/2016.
//  Copyright © 2016 Benjamin Johnson. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Scrapbook {
    
    let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func save() {
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Core Data error \(error)")
        
        }
    }
    
    func populateWithSampleData() {
        
        createCollectionWithName("A")
        createCollectionWithName("B")
        
    }
    
    func createCollectionWithName(name: String) -> Collection {
        // Create Collection
        let collectionEntity = NSEntityDescription.entityForName("Collection", inManagedObjectContext: managedObjectContext)!
        
        let collection = Collection(entity: collectionEntity, insertIntoManagedObjectContext: managedObjectContext)
        collection.name = name
        managedObjectContext.insertObject(collection)
        
        save()
        
        return collection
    }
    
    var collections: [Collection] {
        
        let fetchRequest = NSFetchRequest(entityName: "Collection")
        
        //3
        do {
            let results =
                try managedObjectContext.executeFetchRequest(fetchRequest)
            let collections = results as! [Collection]
            
            return collections
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            return []
        }
    }
    
    var clippings: [Clipping] {
        let fetchRequest = NSFetchRequest(entityName: "Clipping")
        //3
        do {
            let results =
                try managedObjectContext.executeFetchRequest(fetchRequest)
            let clippings = results as! [Clipping]
            return clippings
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            return []
        }
    }
    
    func createClipping(notes: String, image: UIImage) -> Clipping {
        let clippingEntity = NSEntityDescription.entityForName("Clipping", inManagedObjectContext: managedObjectContext)!
        
        let clipping = Clipping(entity: clippingEntity, insertIntoManagedObjectContext: managedObjectContext)
        clipping.notes = notes
        clipping.addImage(image)
        
        clipping.createdAt = NSDate()
        
        managedObjectContext.insertObject(clipping)
        save()
        
        return clipping
    }
    
    
    func createClipping(notes: String, imageURL: String? = nil) -> Clipping {
        let clippingEntity = NSEntityDescription.entityForName("Clipping", inManagedObjectContext: managedObjectContext)!
        
        let clipping = Clipping(entity: clippingEntity, insertIntoManagedObjectContext: managedObjectContext)
        clipping.notes = notes
        clipping.imageURL = imageURL
        clipping.createdAt = NSDate()
        
        managedObjectContext.insertObject(clipping)
        return clipping
    }
    
    func addClippingToCollection(collection: Collection, clipping: Clipping) {
        
        clipping.collection = collection
        try! managedObjectContext.save()
    }
    
    func clippingsWithText(text: String, collection: Collection) -> [Clipping] {
        let fetchRequest = NSFetchRequest(entityName: "Clipping")
        fetchRequest.predicate = NSPredicate(format: "collection == %@ && notes CONTAINS[cd] %@",collection, text)
        
        do {
            let results =
                try managedObjectContext.executeFetchRequest(fetchRequest)
            let clippings = results as! [Clipping]
            return clippings
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            return []
        }
    }
    
    func clippingsWithText(text: String) -> [Clipping] {
        
        let fetchRequest = NSFetchRequest(entityName: "Clipping")
        fetchRequest.predicate = NSPredicate(format: "notes CONTAINS[cd] %@", text)
        
        do {
            let results =
                try managedObjectContext.executeFetchRequest(fetchRequest)
            let clippings = results as! [Clipping]
            return clippings
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            return []
        }
    }
    
    func deleteCollection(collection: Collection) {
        managedObjectContext.deleteObject(collection);
        save()
    }
    
    func deleteClipping(clipping: Clipping) {
        managedObjectContext.deleteObject(clipping);
        save()
    }
    
    
    
    
}