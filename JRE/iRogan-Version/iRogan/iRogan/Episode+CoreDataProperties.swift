//
//  Episode+CoreDataProperties.swift
//  iRogan
//
//  Created by Blake Oistad on 12/14/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Episode {

    @NSManaged var dateEntered: NSDate
    @NSManaged var dateUpdated: NSDate?
    @NSManaged var episodeAudioURL: String
    @NSManaged var episodeDate: NSDate
    @NSManaged var episodeGuests: String
    @NSManaged var episodeNumber: String
    @NSManaged var episodeTitle: String
    @NSManaged var episodeTrackTime: NSNumber
    @NSManaged var userID: String

}
