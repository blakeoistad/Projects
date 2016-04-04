//
//  Flick+CoreDataProperties.swift
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

extension Flick {

    @NSManaged var flickDateEntered: NSDate?
    @NSManaged var flickDateUpdated: NSDate?
    @NSManaged var flickDirector: String
    @NSManaged var flickGenre: String
    @NSManaged var flickImgNamed: String
    @NSManaged var flickIsCollectionItem: NSNumber?
    @NSManaged var flickReleaseDate: NSNumber
    @NSManaged var flickSummary: String
    @NSManaged var flickTitle: String
    @NSManaged var flickRating: String?
    @NSManaged var relationshipToCollection: Collection?

}
