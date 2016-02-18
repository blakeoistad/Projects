//
//  xmlManager.swift
//  xmlAGAIN
//
//  Created by Blake Oistad on 11/30/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class XMLManager: NSObject, NSXMLParserDelegate {

    static let sharedInstance = XMLManager()
    
    //MARK: - Properties
    
    var xmlParser: NSXMLParser!
    var podcasts = [Podcast]()
    
    var entryTitle: String!
    var entryDate: String!
    var entryURL: String!
    var entryDuration: String!
    var entryDescription: String!
    var currentParsedElement = String()
    var weAreInsideAnItem = false
    
    //MARK: - XML Parse Methods
    
    func refreshPodcasts() {
        let urlString = NSURL(string: "http://joeroganexp.joerogan.libsynpro.com/rss")
        let rssURLRequest:NSURLRequest = NSURLRequest(URL: urlString!)
        let queue:NSOperationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(rssURLRequest, queue: queue) { (response, data, error) -> Void in
            self.xmlParser = NSXMLParser(data: data!)
            self.xmlParser.delegate = self
            self.xmlParser.parse()
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
                currentParsedElement = "title"
            case "pubDate":
                entryDate = String()
                currentParsedElement = "pubDate"
            default: break
            }
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if weAreInsideAnItem {
            switch currentParsedElement {
            case "title":
                entryTitle = entryTitle + string
            case "pubDate":
                entryDate = entryDate + string
            default: break
            }
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if weAreInsideAnItem {
            switch elementName {
            case "title":
                currentParsedElement = ""
            case "pubDate":
                currentParsedElement = ""
            default: break
            }
        }
        if elementName == "item" {
            let entryPodcast = Podcast()
            entryPodcast.podcastTitle = entryTitle
            entryPodcast.podcastDate = entryDate
            podcasts.append(entryPodcast)
            weAreInsideAnItem = false
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            print("Received Podcast Data")
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "receivedPodcastData", object: nil))
            
        })
    }
    
}


