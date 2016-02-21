//
//  DataManager.swift
//  jreCast
//
//  Created by Blake Oistad on 11/26/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import CoreData

class DataManager: NSObject {

    static let sharedInstance = DataManager()
    
    
    //MARK: - Properties
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext: NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var episodeArray = [Episode]()
    var filteredEpisodeArray = [Episode]()
    
    //MARK: - Core Data Methods
    
    func removeAllEpisodes() {
        if let toDeleteArray = fetchRecords() {
            for episode in toDeleteArray {
                managedObjectContext.deleteObject(episode)
            }
            appDelegate.saveContext()
        }
    }
    
    func updateEpisodeArray() {
        episodeArray = fetchRecords()!
        filteredEpisodeArray = episodeArray
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "callToRefreshData", object: nil))
    }
    
    func fetchRecords() -> [Episode]? {
        let fetchRequest: NSFetchRequest! = NSFetchRequest(entityName: "Episode")
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "pubDate", ascending: true)]
        
        do {
            let tempArray = try managedObjectContext!.executeFetchRequest(fetchRequest) as! [Episode]
            return tempArray
        } catch {
            print("Nothing in array")
            return nil
        }
    }
    
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateEpisodeArray", name: "parsedEpisodeData", object: nil)
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func tempAddRecords() {
//        let entityDescription: NSEntityDescription! = NSEntityDescription.entityForName("Episode", inManagedObjectContext: managedObjectContext)
//        
//        let currentEpisode: Episode! = Episode(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
//        currentEpisode.episodeTitle = "#717 - Steve-O"
//        currentEpisode.episodeNumber = "# 717"
//        currentEpisode.episodeGuests = "Steve-O"
//        currentEpisode.episodeDate = "11/03/2015"
//        currentEpisode.episodeImageName = "steve-o"
//        currentEpisode.dateEntered = NSDate()
//        currentEpisode.userID = "System"
//        appDelegate.saveContext()
//        
//        let currentEpisode2: Episode! = Episode(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
//        currentEpisode2.episodeTitle = "#718 - Christopher Ryan"
//        currentEpisode2.episodeNumber = "# 718"
//        currentEpisode2.episodeGuests = "Christopher Ryan"
//        currentEpisode2.episodeDate = "11/03/2015"
//        currentEpisode2.episodeImageName = "christopherRyan"
//        currentEpisode2.dateEntered = NSDate()
//        currentEpisode2.userID = "System"
//        appDelegate.saveContext()
//        
//        let currentEpisode3: Episode! = Episode(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
//        currentEpisode3.episodeTitle = "#719 - Josh Olin"
//        currentEpisode3.episodeNumber = "# 719"
//        currentEpisode3.episodeGuests = "Josh Olin"
//        currentEpisode3.episodeDate = "11/04/2015"
//        currentEpisode3.episodeImageName = "joshOlin"
//        currentEpisode3.dateEntered = NSDate()
//        currentEpisode3.userID = "System"
//        appDelegate.saveContext()
//        
//        let currentEpisode4: Episode! = Episode(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
//        currentEpisode4.episodeTitle = "#720 - Tait Fletcher & Andy Stumpf"
//        currentEpisode4.episodeNumber = "# 720"
//        currentEpisode4.episodeGuests = "Tait Fletcher & Andy Stumpf"
//        currentEpisode4.episodeDate = "11/10/2015"
//        currentEpisode4.episodeImageName = "taitFletcher"
//        currentEpisode4.dateEntered = NSDate()
//        currentEpisode4.userID = "System"
//        appDelegate.saveContext()
//        
//        let currentEpisode5: Episode! = Episode(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
//        currentEpisode5.episodeTitle = "#721 - Eddie Bravo"
//        currentEpisode5.episodeNumber = "# 721"
//        currentEpisode5.episodeGuests = "Eddie Bravo"
//        currentEpisode5.episodeDate = "11/11/2015"
//        currentEpisode5.episodeImageName = "eddieBravo"
//        currentEpisode5.dateEntered = NSDate()
//        currentEpisode5.userID = "System"
//        appDelegate.saveContext()
//        
//        let currentEpisode6: Episode! = Episode(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
//        currentEpisode6.episodeTitle = "#722 - Tony Hinchcliffe"
//        currentEpisode6.episodeNumber = "# 722"
//        currentEpisode6.episodeGuests = "Tony Hinchcliffe"
//        currentEpisode6.episodeDate = "11/14/2015"
//        currentEpisode6.episodeImageName = "tonyHinchcliffe"
//        currentEpisode6.dateEntered = NSDate()
//        currentEpisode6.userID = "System"
//        appDelegate.saveContext()
//        
//        let currentEpisode7: Episode! = Episode(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
//        currentEpisode7.episodeTitle = "#723 - Dana White & Tony Hinchcliffe"
//        currentEpisode7.episodeNumber = "# 723"
//        currentEpisode7.episodeGuests = "Dana White & Tony Hinchcliffe"
//        currentEpisode7.episodeDate = "11/16/2015"
//        currentEpisode7.episodeImageName = "danaWhite"
//        currentEpisode7.dateEntered = NSDate()
//        currentEpisode7.userID = "System"
//        appDelegate.saveContext()
//        
//        print("\(currentEpisode) \(currentEpisode2) \(currentEpisode3) \(currentEpisode4) \(currentEpisode5) \(currentEpisode6) \(currentEpisode7)")
//    }
}
