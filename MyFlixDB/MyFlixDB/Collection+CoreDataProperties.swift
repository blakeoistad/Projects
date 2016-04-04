//
//  Collection+CoreDataProperties.swift
//  MyFlixDB
//
//  Created by Blake Oistad on 4/4/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Collection {

    @NSManaged var collectionChildren: NSNumber?
    @NSManaged var collectionDateEntered: NSDate?
    @NSManaged var collectionDateUpdated: NSDate?
    @NSManaged var collectionImgNamed: String?
    @NSManaged var collectionName: String?
    @NSManaged var collectionType: String?
    @NSManaged var relationshipToFlick: Flick?

}
