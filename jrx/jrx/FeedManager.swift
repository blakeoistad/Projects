//
//  FeedManager.swift
//  jrx
//
//  Created by Blake Oistad on 4/10/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//

import UIKit

class FeedManager: NSObject, NSXMLParserDelegate {

    //MARK: - Properties

    static let sharedInstance = FeedManager()
    
    var xmlParser: NSXMLParser!
    
    let feedURL = "joeroganexp.joerogan.libsynpro.com/rss"
    
    var currentlyParsedElement = String()
    var insideAnItem = false
    
    
    //MARK: - XML Parser Methods
    
    func parserDidStartDocument(parser: NSXMLParser) {
        
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        
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
    
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshEpisodes", name: "networkConnected", object: nil)
    }
}
