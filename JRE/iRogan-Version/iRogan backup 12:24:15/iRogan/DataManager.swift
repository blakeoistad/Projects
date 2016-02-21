//
//  DataManager.swift
//  iRogan
//
//  Created by Blake Oistad on 12/6/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import CoreData

class DataManager: NSObject {
    
    static let sharedInstance = DataManager()
    
    
    
    
    // MARK: - Properties
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext: NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var episodeArray = [Episode]()
    var filteredEpisodeArray = [Episode]()
    
    // MARK: - Core Data Methods
    
    func removeAllEpisodes() {
        if let toDeleteArray = fetchRecords() {
            for episode in toDeleteArray {
                managedObjectContext.deleteObject(episode)
            }
            appDelegate.saveContext()
        }
    }
    
    func saveTrackPlacement() {
        appDelegate.saveContext()
    }
    
    func updateEpisodeArray() {
        episodeArray = fetchRecords()!
        filteredEpisodeArray = episodeArray
        self.performSelector(Selector("doRefresh"), withObject: self, afterDelay: 0.5)
    }
    
    func doRefresh() {
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "callToRefreshData", object: nil))
        
    }
    
    func fetchRecords() -> [Episode]? {
        let fetchRequest: NSFetchRequest! = NSFetchRequest(entityName: "Episode")
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
//        updateEpisodeArray()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateEpisodeArray", name: "parsedEpisodeData", object: nil)
    }
}
