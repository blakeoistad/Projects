//
//  Flick+CoreDataProperties.swift
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

extension Flick {

    @NSManaged var flickTitle: String?
    @NSManaged var flickReleaseDate: NSDate?
    @NSManaged var flickImgNamed: String?
    @NSManaged var flickType: String?
    @NSManaged var flickIsCollectionItem: NSNumber?
    @NSManaged var flickSummary: String?
    @NSManaged var flickDirector: String?
    @NSManaged var relationshipToCollection: Collection?

}
