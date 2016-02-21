//
//  FeedManager.swift
//  jreCast
//
//  Created by Blake Oistad on 11/30/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import CoreData

class FeedManager: NSObject, NSXMLParserDelegate {
    
    static let sharedInstance = FeedManager()
    
    //MARK: - Properties
    
    var xmlParser: NSXMLParser!
    var dataManager = DataManager.sharedInstance
    var feedURL = "http://joeroganexp.joerogan.libsynpro.com/rss"
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext: NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var entryTitle: String!
    var entryGuestsString: String!
    var entryNumber: String!
    var entryDate: NSDate!
    var entryURL: String!
    var entryDuration: String!
    var entryDescription: String!
    var entryImageName: String!
    //    var itemKeywords: [String]!
    
    var currentlyParsedElement = String()
    var weAreInsideAnItem = false
    
    //MARK: - XML Parsing Methods
    
    func refreshEpisodes() {
        let urlString = NSURL(string: feedURL)
        let rssURLRequest: NSURLRequest = NSURLRequest(URL: urlString!)
        
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(rssURLRequest) { (data, response, error) -> Void in
            if data != nil {
                print("Got Data")
                
                //Title String Preprocessing
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
        dataManager.removeAllEpisodes()
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
            case "description":
                entryDescription = String()
                currentlyParsedElement = "description"
            case "duration":
                entryDuration = String()
                currentlyParsedElement = "duration"
            case "enclosure":
                let audioURL = attributeDict["url"]! as String
                entryURL = audioURL
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
                
                //Repair Title String for Episodes 10 & 12 (Missing Guest Info)
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
                
                //Split Title String into # & Guests
                if entryTitle.containsString("-") {
                    let splitString = entryTitle.componentsSeparatedByString("-")
                    var episodeNumberString = splitString[0]
                    var episodeGuestsString = splitString[1]
                    entryGuestsString = episodeGuestsString
                    
                    //Episode # Handling
                    if episodeNumberString.containsString("PODCAST#44") {
                        let lessPodcastString = episodeNumberString.stringByReplacingOccurrencesOfString("PODCAST#44", withString: "#44")
                        episodeNumberString = lessPodcastString
                    }
                    if episodeNumberString.containsString("PODCAST#49") {
                        let lessPodcastString = episodeNumberString.stringByReplacingOccurrencesOfString("PODCAST#49", withString: "#49")
                        episodeNumberString = lessPodcastString
                    }
                    
                    
                    //Fight Companion Instances
                    if !episodeNumberString.containsString("Fight Companion") {
                        entryNumber = episodeNumberString
                    } else {
                        let fcString = episodeNumberString.stringByReplacingOccurrencesOfString("Fight Companion", withString: "Fight Companion")
                        entryNumber = fcString
                        let spaceString = ""
                        episodeGuestsString = spaceString
                        entryGuestsString = episodeGuestsString
                    }
                    
                    //JRQE Instances
                    if episodeNumberString.containsString("JRQE") {
                        if episodeNumberString.containsString(" #1") {
                            let addSpaceString = episodeNumberString.stringByReplacingOccurrencesOfString("JRQE #1", withString: "JRQE#1")
                            episodeNumberString = addSpaceString
                        }
                        entryNumber = episodeNumberString
                        
                    }
                    
                    
                    //Guest Handling
                    
                    //Comma From Instances
                    if episodeGuestsString.containsString(", from") {
                        let cleanedFromString = episodeGuestsString.stringByReplacingOccurrencesOfString(",", withString: "")
                        episodeGuestsString = cleanedFromString
                    }
                    //Comma Ph.D Instances
                    if episodeGuestsString.containsString(", Ph") {
                        let cleanedPHDString = episodeGuestsString.stringByReplacingOccurrencesOfString(",", withString: "")
                        episodeGuestsString = cleanedPHDString
                    }
                    //Comma Jr. Instances
                    if episodeGuestsString.containsString(", Jr.") {
                        let cleanedJrString = episodeGuestsString.stringByReplacingOccurrencesOfString(",", withString: "")
                        episodeGuestsString = cleanedJrString
                    }
                    //Joey Coco Diaz Instances
                    if episodeGuestsString.containsString("Joey Diaz") {
                        let addCocoString = episodeGuestsString.stringByReplacingOccurrencesOfString("Joey Diaz", withString: "Joey 'CoCo' Diaz")
                        episodeGuestsString = addCocoString
                    }
                    //B-Real Instance
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
                    //Question Mark Instances
                    if episodeGuestsString.containsString("?") {
                        let lessQuestionString = episodeGuestsString.stringByReplacingOccurrencesOfString("?", withString: "")
                        entryGuestsString = lessQuestionString
                    }
                    
                    //                    print("Number: \(entryNumber) Guests: \(entryGuestsString)")
                }
                
            case "pubDate":
                //                entryDate = string
                
                let formatter = NSDateFormatter()
                formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
                let dateFromString = formatter.dateFromString(string)
                entryDate = dateFromString
                
            case "description":
                entryDescription = entryDescription + string
            case "duration":
                entryDuration = entryDuration + string
            case "enclosure":
                entryURL = entryURL + string
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
            case "description":
                currentlyParsedElement = ""
            case "duration":
                currentlyParsedElement = ""
            case "enclosure":
                currentlyParsedElement = ""
            default: break
            }
        }
        
        if elementName == "item" {
            //            print("\(entryTitle)")
            let itemEpisode = NSEntityDescription.insertNewObjectForEntityForName("Episode", inManagedObjectContext: self.managedObjectContext!) as! Episode
            itemEpisode.episodeTitle = entryTitle
            itemEpisode.episodeNumber = entryNumber
            itemEpisode.episodeGuestsString = entryGuestsString
            itemEpisode.episodeDate = entryDate
            itemEpisode.episodeAudioURL = entryURL
            itemEpisode.episodeDescription = entryDescription
            itemEpisode.episodeDuration = entryDuration
            itemEpisode.episodeImageName = entryImageName
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