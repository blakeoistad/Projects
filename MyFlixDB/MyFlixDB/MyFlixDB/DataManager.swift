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
    var horrorArray = [Flick]()
    var actionAdventureArray = [Flick]()
    var fantasyAnimationArray = [Flick]()
    var documentaryArray = [Flick]()
    var dramaArray = [Flick]()
    var comedyArray = [Flick]()
    var scifiArray = [Flick]()
    var mysteryThrillerArray = [Flick]()
    var yearsArray = [Int]()
    
    var baseURLString = "www.omdbapi.com"
    var searchString = String()
    
    var flickToTransfer : Flick?
    
    func tempAddRecords() {
        let entityDescription: NSEntityDescription! = NSEntityDescription.entityForName("Flick", inManagedObjectContext: managedObjectContext)
        let flick1 :Flick! = Flick(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        flick1.flickTitle = "Jurassic Park"
        flick1.flickSummary = "A bunch of dumb people go to an island filled with live dinosaurs, assuming nothing bad will happen."
        flick1.flickGenre = "Action-Adventure"
        flick1.flickDirector = "Stephen Speilberg"
        flick1.flickReleaseDate = 1993
        
        let flick2 :Flick! = Flick(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        flick2.flickTitle = "Dumb & Dumber"
        flick2.flickSummary = "Two dumb guys do dumb things on a dumb roadtrip. Dumb. Awesome."
        flick2.flickGenre = "Comedy"
        flick2.flickDirector = "Farrelly Bros"
        flick2.flickReleaseDate = 1994
        
        let flick3 :Flick! = Flick(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        flick3.flickTitle = "Leprechaun"
        flick3.flickSummary = "A small, horrific leprechaun terrorizes people with magical powers and twisted violence."
        flick3.flickGenre = "Horror"
        flick3.flickDirector = "Mark Jones"
        flick3.flickReleaseDate = 1993
        
        let flick4 :Flick! = Flick(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        flick4.flickTitle = "Forgetting Sarah Marshall"
        flick4.flickSummary = "Dudeman gets dumped by his cheating girlfriend, accidentally takes vacation where she and other dude are."
        flick4.flickGenre = "Comedy"
        flick4.flickDirector = "Nicholas Stoller"
        flick4.flickReleaseDate = 2008
        
        let flick5 :Flick! = Flick(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        flick5.flickTitle = "Limelight"
        flick5.flickSummary = "A documentary about club kids, drugs, and dance life in the 80's and 90's."
        flick5.flickGenre = "Documentary"
        flick5.flickDirector = "Billy Corben"
        flick5.flickReleaseDate = 2011
        
        let flick6 :Flick! = Flick(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        flick6.flickTitle = "Legend"
        flick6.flickSummary = "A Tom Cruise movie about unicorns and magic stuff."
        flick6.flickGenre = "Fantasy-Animation"
        flick6.flickDirector = "Ridley Scott"
        flick6.flickReleaseDate = 1985
        
        let flick7 :Flick! = Flick(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        flick7.flickTitle = "A Beautiful Mind"
        flick7.flickSummary = "A sad movie about ya boy with that mind disease that makes him see things and people."
        flick7.flickGenre = "Drama"
        flick7.flickDirector = "Ron Howard"
        flick7.flickReleaseDate = 2001
        
        let flick8 :Flick! = Flick(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        flick8.flickTitle = "Close Encounters of the Third Kind"
        flick8.flickSummary = "An alien movie about a guy that likes to build mashed potato mountains."
        flick8.flickGenre = "Sci-Fi"
        flick8.flickDirector = "Poochimus Maximus"
        flick8.flickReleaseDate = 1977
        
        let flick9 :Flick! = Flick(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        flick9.flickTitle = "Sleuth"
        flick9.flickSummary = "A pretty crazy mystery movie that I need to see again."
        flick9.flickGenre = "Mystery-Thriller"
        flick9.flickDirector = "Joseph Mankiewicz"
        flick9.flickReleaseDate = 1972
        
        let flick10 :Flick! = Flick(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        flick10.flickTitle = "Knocked Up"
        flick10.flickSummary = "A funny damn movie about what happens when you get drunk and decide not to wear a condom."
        flick10.flickGenre = "Comedy"
        flick10.flickDirector = "Judd Apatow"
        flick10.flickReleaseDate = 2007
        
        appDelegate.saveContext()
    }
    
    func fetchFlicks() -> [Flick]? {
        
        let fetchRequest :NSFetchRequest! = NSFetchRequest(entityName: "Flick")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "flickTitle", ascending: true)]
        do {
            let tempArray = try managedObjectContext!.executeFetchRequest(fetchRequest) as! [Flick]
            flicksArray = tempArray
            return flicksArray
        } catch {
            return nil
        }
        
    }
    
    
    func getArrayDetails() {
        print("-DM- \(genresArray.count) Genres in genreArray")
        print("-DM- \(flicksArray.count) Flicks in flicksArray")
        print("-DM- \(horrorArray.count) Flicks in horrorArray")
        print("-DM- \(actionAdventureArray.count) Flicks in actionAdventureArray")
        print("-DM- \(fantasyAnimationArray.count) Flicks in fantasyAnimationArray")
        print("-DM- \(documentaryArray.count) Flicks in documentaryArray")
        print("-DM- \(dramaArray.count) Flicks in dramaArray")
        print("-DM- \(comedyArray.count) Flicks in comedyArray")
        print("-DM- \(scifiArray.count) Flicks in scifiArray")
        print("-DM- \(mysteryThrillerArray.count) Flicks in mysteryThrillerArray\n")
    }
    
    func filterGenreArrays() {
        flicksArray.sortInPlace { $0.flickTitle < $1.flickTitle }
        for flick in flicksArray {
            if flick.flickGenre == "Horror" {
                horrorArray.append(flick)
            } else if flick.flickGenre == "Action" || flick.flickGenre == "Adventure" {
                actionAdventureArray.append(flick)
            } else if flick.flickGenre == "Fantasy" || flick.flickGenre == "Animation" {
                fantasyAnimationArray.append(flick)
            } else if flick.flickGenre == "Documentary" {
                documentaryArray.append(flick)
            } else if flick.flickGenre == "Drama" {
                dramaArray.append(flick)
            } else if flick.flickGenre == "Comedy" {
                comedyArray.append(flick)
            } else if flick.flickGenre == "Sci-Fi" {
                scifiArray.append(flick)
            } else if flick.flickGenre == "Mystery" || flick.flickGenre == "Thriller" {
                mysteryThrillerArray.append(flick)
            }
        }
    }
    
    func updateHorrorArray(flick: Flick) {
            print("-DM- Adding \(flick.flickTitle) to horrorArray")
            horrorArray.append(flick)
    }
    
    func updateActionAdventureArray(flick: Flick) {
        print("-DM- Adding \(flick.flickTitle) to actionAdventureArray")
        actionAdventureArray.append(flick)
    }
    
    func updateFantasyAnimationArray(flick: Flick) {
        print("-DM- Adding \(flick.flickTitle) to fantasyAnimationArray")
        fantasyAnimationArray.append(flick)
    }
    
    func updateDocumentaryArray(flick: Flick) {
        print("-DM- Adding \(flick.flickTitle) to documentaryArray")
        documentaryArray.append(flick)
    }
    
    func updateDramaArray(flick: Flick) {
        print("-DM- Adding \(flick.flickTitle) to dramaArray")
        dramaArray.append(flick)
    }
    
    func updateComedyArray(flick: Flick) {
        print("-DM- Adding \(flick.flickTitle) to comedyArray")
        comedyArray.append(flick)
    }
    
    func updateSciFiArray(flick: Flick) {
        print("-DM- Adding \(flick.flickTitle) to sciFiArray")
        scifiArray.append(flick)
    }
    
    func updateMysteryThrillerArray(flick: Flick) {
        print("-DM- Adding \(flick.flickTitle) to mysteryThrillerArray")
        mysteryThrillerArray.append(flick)
    }
    
    
    func fillYearsArray() {
        for (var i=1900; i<2017; i++) {
            //print("Value is: \(i)")
            yearsArray.append(i)
            yearsArray.sortInPlace { $0 > $1 }
            appDelegate.saveContext()
        }
    }
    
    //MARK: - OMDB Methods
    
    func parseMovieData(data: NSData) -> Flick {
//        flickToTransfer = Flick()
        do {
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            let tempDictArray = jsonResult as! NSDictionary
            
            flickToTransfer = NSEntityDescription.insertNewObjectForEntityForName("Flick", inManagedObjectContext: appDelegate.managedObjectContext) as! Flick
            
            flickToTransfer!.flickTitle = tempDictArray.objectForKey("Title") as! String
            flickToTransfer!.flickDirector = tempDictArray.objectForKey("Director") as! String
            flickToTransfer!.flickReleaseDate = (tempDictArray.objectForKey("Year") as! NSString).integerValue
            flickToTransfer!.flickSummary = tempDictArray.objectForKey("Plot") as! String
            flickToTransfer!.flickImgNamed = tempDictArray.objectForKey("Poster") as! String
            let posterURL = tempDictArray.objectForKey("Poster") as! String
            if posterURL != "" {
                flickToTransfer!.flickImgNamed = posterURL
            } else {
                print("-DM- NO POSTER INFORMATION")
            }
            
            
            var flickGenreString = String()
            flickGenreString = tempDictArray.objectForKey("Genre") as! String
            print("-DM- Possible Genres: \(flickGenreString)\n")
            let separatedString = flickGenreString.componentsSeparatedByString(",")
            flickToTransfer!.flickGenre = separatedString[0]
            if separatedString[0] == "Crime" {
                flickToTransfer!.flickGenre = "Mystery"
            } else if separatedString[0] == "Biography" {
                flickToTransfer!.flickGenre = "Drama"
            } else {
                flickToTransfer!.flickGenre = separatedString[0]
            }
          
            print("-DM-\nnewFlick: \nTitle: \(flickToTransfer!.flickTitle)\nDirector: \(flickToTransfer!.flickDirector)\nReleased In: \(flickToTransfer!.flickReleaseDate)\nSummary: \(flickToTransfer!.flickSummary)\nGenre: \(flickToTransfer!.flickGenre)\nimgURL: \(flickToTransfer!.flickImgNamed)")
            

//            appDelegate.saveContext()
            

            dispatch_async(dispatch_get_main_queue()) {
                print("-DM- Transferring \(self.flickToTransfer!.flickTitle)")
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "newDataReceived", object: self.flickToTransfer))
            }
            
            
        } catch {
            print("-DM- JSON Parsing Error")
        }
        return flickToTransfer!
    }

    
    func getDataFromServer(searchString: String) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        defer {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        let url = NSURL(string: "https://\(baseURLString)/?t=\(searchString)&y=&plot=short&r=json")
        let urlRequest = NSURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 30.0)
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            if data != nil {
                print("-DM- Got Data!")
                self.parseMovieData(data!)
            } else {
                print("-DM- No Data")
            }
        }
        task.resume()
    }

    
    
    //MARK: - Initializer
    
    override init() {
        super.init()
//        self.tempAddRecords()
        self.fillYearsArray()
        self.fetchFlicks()
        self.filterGenreArrays()
        self.getArrayDetails()

    }
    
}
