//
//  Episode+CoreDataProperties.swift
//  jreCast
//
//  Created by Blake Oistad on 12/4/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Episode {

    @NSManaged var dateEntered: NSDate?
    @NSManaged var dateUpdated: NSDate?
    @NSManaged var episodeDate: NSDate?
    @NSManaged var episodeDescription: String?
    @NSManaged var episodeDuration: String?
    @NSManaged var episodeGuests: String?
    @NSManaged var episodeGuestsString: String?
    @NSManaged var episodeImageName: String?
    @NSManaged var episodeAudioURL: String?
    @NSManaged var episodeNumber: String?
    @NSManaged var episodeSponsors: String?
    @NSManaged var episodeTitle: String?
    @NSManaged var userID: String?
    @NSManaged var relationshipToGuest: Guest?

}
