//
//  DataManager.swift
//  MyFlixDB
//
//  Created by Blake Oistad on 2/21/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//

import UIKit
import CoreData

class DataManager: NSObject {

    static let sharedInstance = DataManager()
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext: NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var genresArray = ["Horror", "Action-Adventure", "Fantasy-Animation", "Documentary", "Drama", "Comedy", "Sci-Fi", "Mystery-Thriller"]
    var flicksArray = [Flick]()
    
    func tempAddRecords() {
        let entityDescription: NSEntityDescription! = NSEntityDescription.entityForName("Flick", inManagedObjectContext: managedObjectContext)
        let currentFlick :Flick! = Flick(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        currentFlick.flickTitle = "Jurassic Park"
        currentFlick.flickSummary = "A bunch of dumb people go to an island filled with live dinosaurs, assuming nothing bad will happen."
        currentFlick.flickGenre = "Action-Adventure"
        currentFlick.flickDirector = "Stephen Speilberg"
    }
    
    
//    func tempAddRecords() {
//        let entityDescription :NSEntityDescription! = NSEntityDescription.entityForName("ToDos", inManagedObjectContext: managedObjectContext)
//        let currentToDo :ToDos! = ToDos(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
//        currentToDo.todoDescription = "Fold the laundry"
//        currentToDo.todoComplete = false
//        currentToDo.todoDateDue = NSDate()
//        currentToDo.dateEntered = NSDate()
//        currentToDo.userID = "System"
//        appDelegate.saveContext()
//    }
    
}
