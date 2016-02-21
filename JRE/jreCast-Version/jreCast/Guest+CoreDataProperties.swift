//
//  Guest+CoreDataProperties.swift
//  jreCast
//
//  Created by Blake Oistad on 11/30/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Guest {

    @NSManaged var guestFacebookID: String?
    @NSManaged var guestImage: String?
    @NSManaged var guestName: String?
    @NSManaged var guestTwitterID: String?
    @NSManaged var guestWebsite: String?
    @NSManaged var relationshipToEpisode: Episode?

}
