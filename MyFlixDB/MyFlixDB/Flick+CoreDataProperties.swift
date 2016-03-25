//
//  Flick+CoreDataProperties.swift
//  MyFlixDB
//
//  Created by Blake Oistad on 3/25/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Flick {

    @NSManaged var flickDirector: String?
    @NSManaged var flickImgNamed: String?
    @NSManaged var flickIsCollectionItem: NSNumber?
    @NSManaged var flickReleaseDate: NSDate?
    @NSManaged var flickSummary: String?
    @NSManaged var flickTitle: String
    @NSManaged var flickGenre: String
    @NSManaged var relationshipToCollection: Collection?

}
