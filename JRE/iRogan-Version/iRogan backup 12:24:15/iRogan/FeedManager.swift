//
//  FeedManager.swift
//  iRogan
//
//  Created by Blake Oistad on 12/6/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import CoreData

class FeedManager: NSObject, NSXMLParserDelegate {
    
    static let sharedInstance = FeedManager()
    
    // MARK: - Properties
    
    var dataManager = DataManager.sharedInstance
    var xmlParser: NSXMLParser!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext: NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    let feedURL = "joeroganexp.joerogan.libsynpro.com/rss"
    
    var entryTitle: String!
    var entryGuestsString: String!
    var entryNumber: String!
    var entryDate: NSDate!
    var entryAudioURL: String!
    var entryImageName: String!
    
    var currentlyParsedElement = String()
    var weAreInsideAnItem = false
    
    // MARK: - XML Parsing Methods
    
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshEpisodes", name: "networkConnected", object: nil)
    }
    
    func refreshEpisodes() {
        let urlString = NSURL(string: "http://\(feedURL)")
        let rssURLRequest: NSURLRequest = NSURLRequest(URL: urlString!)
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(rssURLRequest) { (data, response, error) -> Void in
            if data != nil {
                print("Got Data")
                let dataString = NSString.init(data: data!, encoding: NSUTF8StringEncoding)
                let dataLessQuoteString = dataString!.stringByReplacingOccurrencesOfString("&quot;", withString: "\"")
                let dataLessAmpString = dataLessQuoteString.stringByReplacingOccurrencesOfString("&amp;", withString: "and")
                let dataLessEnString = dataLessAmpString.stringByReplacingOccurrencesOfString(" – ", withString: " - ")
                let dataLessEmString = dataLessEnString.stringByReplacingOccurrencesOfString(" — ", withString: " - ")
                let dataLessPODCASTString = dataLessEmString.stringByReplacingOccurrencesOfString("PODCAST ", withString: "")
                let dataLessJREString = dataLessPODCASTString.stringByReplacingOccurrencesOfString("JRE ", withString: "")
                let newData = dataLessJREString.dataUsingEncoding(NSUTF8StringEncoding)
//                print("DataStringUTF8:\(dataLessJREString)")
                self.xmlParser = NSXMLParser(data: newData!)
                self.xmlParser.delegate = self
                self.xmlParser.parse()
            } else {
                print("Error Getting Data")
            }
        }
        task.resume()
    }
    
    func parserDidStartDocument(parser: NSXMLParser) {
        if !dataManager.filteredEpisodeArray.isEmpty {
            dataManager.removeAllEpisodes()
        }
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if elementName == "item" {
            weAreInsideAnItem = true
        }
        if weAreInsideAnItem {
            switch elementName {
            case "title":
                entryTitle = String()
                currentlyParsedElement = "title"
            case "pubDate":
                entryDate = NSDate()
                currentlyParsedElement = "pubDate"
            case "enclosure":
                let audioURL = attributeDict["url"]! as String
                entryAudioURL = audioURL
                currentlyParsedElement = "enclosure"
            default: break
            }
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if weAreInsideAnItem {
            switch currentlyParsedElement {
            case "title":
                entryTitle = string
                if entryTitle == "#10" {
                    entryTitle = "#10 - Joe Rogan"
                }
                if entryTitle == "#12" {
                    entryTitle = "#12 - Joe Rogan"
                }
                if entryTitle == "Podcast from a Car" {
                    entryTitle = "Podcast from a Car - Bryan Callen"
                }
                if entryTitle == "Podcast from a Car #2" {
                    entryTitle = "Podcast from a Car #2 - Cameron Haynes"
                }
                if entryTitle == "Podcast in a Swedish Hotel Room" {
                    entryTitle = "Podcast in a Swedish Hotel Room - Tony Hinchcliffe"
                }
                if entryTitle.containsString("-") {
                    let splitString = entryTitle.componentsSeparatedByString("-")
                    var episodeNumberString = splitString[0]
                    var episodeGuestsString = splitString[1]
                    entryGuestsString = episodeGuestsString
                    if episodeNumberString.containsString("PODCAST#44") {
                        let lessPodcastString = episodeNumberString.stringByReplacingOccurrencesOfString("PODCAST#44", withString: "#44")
                        episodeNumberString = lessPodcastString
                    }
                    if episodeNumberString.containsString("PODCAST#49") {
                        let lessPodcastString = episodeNumberString.stringByReplacingOccurrencesOfString("PODCAST#49", withString: "#49")
                        episodeNumberString = lessPodcastString
                    }
                    if !episodeNumberString.containsString("Fight Companion") {
                        entryNumber = episodeNumberString
                    } else {
                        let fcString = episodeNumberString.stringByReplacingOccurrencesOfString("Fight Companion", withString: "Fight Companion")
                        entryNumber = fcString
                        let spaceString = ""
                        episodeGuestsString = spaceString
                        entryGuestsString = episodeGuestsString
                    }
                    if episodeNumberString.containsString("JRQE") {
                        if episodeNumberString.containsString(" #1") {
                            let addSpaceString = episodeNumberString.stringByReplacingOccurrencesOfString("JRQE #1", withString: "JRQE#1")
                            episodeNumberString = addSpaceString
                        }
                        entryNumber = episodeNumberString
                    }
                    if episodeGuestsString.containsString(", from") {
                        let cleanedFromString = episodeGuestsString.stringByReplacingOccurrencesOfString(",", withString: "")
                        episodeGuestsString = cleanedFromString
                    }
                    if episodeGuestsString.containsString(", Ph") {
                        let cleanedPHDString = episodeGuestsString.stringByReplacingOccurrencesOfString(",", withString: "")
                        episodeGuestsString = cleanedPHDString
                    }
                    if episodeGuestsString.containsString(", Jr.") {
                        let cleanedJrString = episodeGuestsString.stringByReplacingOccurrencesOfString(",", withString: "")
                        episodeGuestsString = cleanedJrString
                    }
                    if episodeGuestsString.containsString("Joey Diaz") {
                        let addCocoString = episodeGuestsString.stringByReplacingOccurrencesOfString("Joey Diaz", withString: "Joey 'CoCo' Diaz")
                        episodeGuestsString = addCocoString
                    }
                    if episodeNumberString.containsString("#189") {
                        episodeGuestsString = " B-Real, Brian Redban"
                        entryGuestsString = episodeGuestsString
                    }
                    if episodeNumberString.containsString("#717") {
                        episodeGuestsString = "Steve-O"
                        entryGuestsString = episodeGuestsString
                    }
                    if episodeNumberString.containsString("#433") {
                        episodeGuestsString = "Duncan Trussell, Chris Ryan, PhD"
                        entryGuestsString = episodeGuestsString
                    }
                    if episodeGuestsString.containsString("?") {
                        let lessQuestionString = episodeGuestsString.stringByReplacingOccurrencesOfString("?", withString: "")
                        entryGuestsString = lessQuestionString
                    }
//                    print("Number: \(entryNumber) Guests: \(entryGuestsString)")
                }
                
            case "pubDate":
                let formatter = NSDateFormatter()
                formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
                let dateFromString = formatter.dateFromString(string)
                entryDate = dateFromString
            case "enclosure":
                entryAudioURL = entryAudioURL + string
            default: break
            }
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if weAreInsideAnItem {
            switch elementName {
            case "title":
                currentlyParsedElement = ""
            case "pubDate":
                currentlyParsedElement = ""
            case "enclosure":
                currentlyParsedElement = ""
            default: break
            }
        }
        if elementName == "item" {
            let itemEpisode = NSEntityDescription.insertNewObjectForEntityForName("Episode", inManagedObjectContext: self.managedObjectContext!) as! Episode
            itemEpisode.episodeNumber = entryNumber
            itemEpisode.episodeGuests = entryGuestsString
            itemEpisode.episodeDate = entryDate
            itemEpisode.episodeAudioURL = entryAudioURL
            itemEpisode.episodeTrackTime = 0.0
            itemEpisode.dateEntered = NSDate()
            itemEpisode.userID = "System"
//            print("Current Track Info:\n Episode Number: \(itemEpisode.episodeNumber)\n Episode Guests: \(itemEpisode.episodeGuests)\n Episode Date: \(itemEpisode.episodeDate)\n Episode URL: \(itemEpisode.episodeAudioURL)\n Episode Track Time: \(itemEpisode.episodeTrackTime)\n Episode Entered: \(itemEpisode.dateEntered)\n Episode UserID: \(itemEpisode.userID)")
            appDelegate.saveContext()
            weAreInsideAnItem = false
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            print("Received Episode Data")
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "parsedEpisodeData", object: nil))
        })
    }
    
}
