//
//  Episode+CoreDataProperties.swift
//  jrx
//
//  Created by Blake Oistad on 4/30/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Episode {

    @NSManaged var episodeAudioURL: String
    @NSManaged var episodeDescription: String
    @NSManaged var episodeGuests: String?
    @NSManaged var episodeImageURL: String
    @NSManaged var episodeKeywords: String
    @NSManaged var episodeReleaseDate: NSDate
    @NSManaged var episodeState: String
    @NSManaged var episodeTitle: String
    @NSManaged var episodeTrackPlacement: NSNumber
    @NSManaged var episodeNumber: String?

    enum playState {
        case UnPlayed
        case InProgress
        case Played
    }
}
