//
//  Clipping+CoreDataProperties.swift
//  Scrapbook
//
//  Created by Ben Johnson on 18/04/2016.
//  Copyright © 2016 Benjamin Johnson. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Clipping {

    @NSManaged var notes: String!
    @NSManaged var imageURL: String?
    @NSManaged var createdAt: NSDate
    @NSManaged var collection: NSManagedObject?

}
