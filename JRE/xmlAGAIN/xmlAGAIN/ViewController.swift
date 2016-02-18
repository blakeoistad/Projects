//
//  ViewController.swift
//  xmlAGAIN
//
//  Created by Blake Oistad on 11/28/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate {

    
    //MARK: - Properties
    
    var networkManager = NetworkManager.sharedInstance
    
    var xmlParser: NSXMLParser!
    var podcasts = [Podcast]()
    
    var entryTitle: String!
    var entryDate: String!
    var entryURL: String!
    var entryDuration: String!
    var entryDescription: String!
    var currentParsedElement = String()
    var weAreInsideAnItem = false
    
    @IBOutlet var podcastTableView: UITableView!
    
    
    //MARK: - Table View Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomTableViewCell
        let currentPodcast = podcasts[indexPath.row]
        
        cell.episodeTitleLabel!.text = currentPodcast.podcastTitle
        cell.episodeDateLabel!.text = currentPodcast.podcastDate
        
        return cell
    }
    
    
    //MARK: - XML Methods
    
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
    
    func refreshData() {
        podcastTableView.reloadData()
        print("Reloaded Table View")
    }
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshPodcasts()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshData", name: "receivedPodcastData", object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

