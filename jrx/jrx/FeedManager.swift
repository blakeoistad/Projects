//
//  FeedManager.swift
//  jrx
//
//  Created by Blake Oistad on 4/10/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//

import UIKit
import CoreData

class FeedManager: NSObject, NSXMLParserDelegate {

    //MARK: - Properties

    static let sharedInstance = FeedManager()
    var dataManager = DataManager.sharedInstance
    
    var xmlParser: NSXMLParser!
    
    let feedURL = "joeroganexp.joerogan.libsynpro.com/rss"
    
    var currentlyParsedElement = String()
    var insideAnItem = false
    
    var entryTitle: String!
    var entryNumber: String!
    var entryGuestsString: String!
    var entryReleaseDate: NSDate!
    var entryAudioURL: String!
    var entryImageURL: String!
    var entryDescription: String!
    var entryKeywordString: String!
    var entryTrackPlace: Double = 0
    
    
    //MARK: - Manager Methods
    
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshEpisodes", name: "networkConnected", object: nil)
        print("now")
    }
    
    func refreshEpisodes() {
        print("FeedManager:\n-Got to refreshEpisodes()")
        let urlString = NSURL(string: "http://\(feedURL)")
        let rssURLRequest = NSURLRequest(URL: urlString!)
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(rssURLRequest) { (data, response, error) -> Void in
            if data != nil {
                print("FeedManager:\n-Request: Got Data!")
                let dataString = NSString.init(data: data!, encoding: NSUTF8StringEncoding)
                let dataLessQuoteString = dataString!.stringByReplacingOccurrencesOfString("&quot;", withString: "\"")
                let dataLessAmpString = dataLessQuoteString.stringByReplacingOccurrencesOfString("&amp;", withString: "and")
                let dataLessEnString = dataLessAmpString.stringByReplacingOccurrencesOfString(" – ", withString: " - ")
                let dataLessEmString = dataLessEnString.stringByReplacingOccurrencesOfString(" — ", withString: " - ")
                let dataLessPODCASTString = dataLessEmString.stringByReplacingOccurrencesOfString("PODCAST ", withString: "")
                let dataLessJREString = dataLessPODCASTString.stringByReplacingOccurrencesOfString("JRE ", withString: "")
                let newData = dataLessJREString.dataUsingEncoding(NSUTF8StringEncoding)
                //                print("FeedManager:\n-RSS Contents: \(dataLessJREString)")
                self.xmlParser = NSXMLParser(data: newData!)
                self.xmlParser.delegate = self
                self.xmlParser.parse()
            } else {
                print("FeedManager:\n-Request: Error Getting Data!\n\(error)")
            }
        }
        task.resume()
        
    }

    
    
    //MARK: - XML Parser Methods
    
    func parserDidStartDocument(parser: NSXMLParser) {
        print("FeedManager:\nParserDidStartDocument")
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if elementName == "item" {
            insideAnItem = true
        }
        if insideAnItem {
            switch elementName {
            case "title":
                entryTitle = String()
                currentlyParsedElement = "title"
            case "pubDate":
                entryReleaseDate = NSDate()
                currentlyParsedElement = "pubDate"
            case "enclosure":
                let audioURL = attributeDict["url"]! as String
                entryAudioURL = audioURL
                currentlyParsedElement = "enclosure"
            case "description":
                entryDescription = String()
                currentlyParsedElement = "description"
            case "itunes:keywords":
                entryKeywordString = String()
                currentlyParsedElement = "itunes:keywords"
            case "itunes:image":
                let imageURL = attributeDict["href"]! as String
                entryImageURL = imageURL
                currentlyParsedElement = "itunes:image"
            default: break
            }
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if insideAnItem {
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
                }
                
            case "pubDate":
                let formatter = NSDateFormatter()
                formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
                let dateFromString = formatter.dateFromString(string)
                entryReleaseDate = dateFromString
            case "enclosure":
                entryAudioURL = entryAudioURL + string
            case "description":
                entryDescription = entryDescription + string
            case "itunes:keywords":
                entryKeywordString = entryKeywordString + string
            case "itunes:image":
                entryImageURL = entryImageURL + string
            default: break
            }
        }

        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if insideAnItem {
            switch elementName {
            case "title":
                resetCurrentlyParsedElement()
            case "pubDate":
                resetCurrentlyParsedElement()
            case "enclosure":
                resetCurrentlyParsedElement()
            case "description":
                resetCurrentlyParsedElement()
            case "itunes:keywords":
                resetCurrentlyParsedElement()
            case "itunes:image":
                resetCurrentlyParsedElement()
            default: break
            }
        }
        if elementName == "item" {
            let itemEpisode = NSEntityDescription.insertNewObjectForEntityForName("Episode", inManagedObjectContext: dataManager.managedObjectContext) as! Episode
            itemEpisode.episodeTitle = entryTitle
            itemEpisode.episodeNumber = entryNumber
            itemEpisode.episodeGuests = entryGuestsString
            itemEpisode.episodeAudioURL = entryAudioURL
            itemEpisode.episodeImageURL = entryImageURL
            itemEpisode.episodeReleaseDate = entryReleaseDate
            itemEpisode.episodeKeywords = entryKeywordString
            itemEpisode.episodeDescription = entryDescription
            itemEpisode.episodeTrackPlacement = 0
            itemEpisode.episodeState = String(Episode.playState.UnPlayed)
            
            print("\nCurrent Track Info:\nEpisode Number: \(itemEpisode.episodeNumber)\n Episode Title: \(itemEpisode.episodeTitle)\n Episode Guests: \(itemEpisode.episodeGuests)\n Episode Release Date: \(itemEpisode.episodeReleaseDate)\n Episode Audio URL: \(itemEpisode.episodeAudioURL)\n Episode Image URL: \(itemEpisode.episodeImageURL)\n Epiosde Keywords: \(itemEpisode.episodeKeywords)\n Episode Description: \(itemEpisode.episodeDescription)\n Episode State: \(itemEpisode.episodeState)")
            
            //Add SaveContext Here
            insideAnItem = false
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        
    }
    
    //MARK: - Helper Methods
    
    func resetCurrentlyParsedElement() {
        currentlyParsedElement = ""
    }
    
}
