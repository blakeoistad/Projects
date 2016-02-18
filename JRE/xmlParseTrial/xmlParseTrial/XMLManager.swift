//
//  XMLManager.swift
//  xmlParseTrial
//
//  Created by Blake Oistad on 11/28/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

@objc protocol XMLParserDelegate{
    func parsingWasFinished()
}

class XMLManager: NSObject, NSXMLParserDelegate {

    static let sharedInstance = XMLManager()
    
    //MARK: - Properties
    
    var xmlDelegate: XMLParserDelegate?
    var currentElement = ""
    var foundCharacters = ""
    var parsedDataArray = [Dictionary<String, String>]()
    var currentDataDictionary = Dictionary<String, String>()
    var feedURLString = "http://joeroganexp.joerogan.libsynpro.com/rss"
    var elementsArray = [String]()
    
    
    //MARK: - XML Parser Methods
    
    func startParsingWithContentsOfURL(rssURL: NSURL) {
        let parser = NSXMLParser(contentsOfURL: rssURL)
        parser!.delegate = self
        parser!.parse()
        print("Successfully parsed RSS Feed")
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        currentElement = elementName
//        print("Current Element: \(elementName)")
    }

    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if currentElement == "title"
            || currentElement == "pubDate"
            || currentElement == "link"
            || currentElement == "itunes:image"
            || currentElement == "description"
            || currentElement == "enclosure"
            || currentElement == "itunes:duration"
            || currentElement == "itunes:keywords" {
                
            foundCharacters += string
                print(string)
                if string.containsString("\n") || string.containsString("\t") {
                    let noNString = string.stringByReplacingOccurrencesOfString("\n", withString: "")
                    let cleanString = noNString.stringByReplacingOccurrencesOfString("\t", withString: "")
//                    print("Successfully Parsed: \(cleanString)")
                }
        }
        
        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if !foundCharacters.isEmpty {
            if elementName == "title" {
                foundCharacters = (foundCharacters as NSString) as String
            }
            currentDataDictionary[elementName] = foundCharacters
            foundCharacters = ""
            parsedDataArray.append(currentDataDictionary)
//            print("Current Data Dictionary: \(parsedDataArray)")
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        xmlDelegate?.parsingWasFinished()
        print("Finished Parsing Feed")
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print("Parsing Error: \(parseError.description)")
    }
    
    func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
        print("Validation Error: \(validationError.description)")
    }
    
}
