//
//  Collection+CoreDataProperties.swift
//  MyFlixDB
//
//  Created by Blake Oistad on 2/21/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Collection {

    @NSManaged var collectionName: String?
    @NSManaged var collectionChildren: NSNumber?
    @NSManaged var collectionImgNamed: String?
    @NSManaged var collectionType: String?
    @NSManaged var relationshipToFlick: NSManagedObject?

}
