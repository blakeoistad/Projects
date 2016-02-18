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
    var xmlManager = XMLManager.sharedInstance
    
    
    @IBOutlet var podcastTableView: UITableView!
    
    
    //MARK: - Table View Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return xmlManager.podcasts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomTableViewCell
        let currentPodcast = xmlManager.podcasts[indexPath.row]
        
        cell.episodeTitleLabel!.text = currentPodcast.podcastTitle
        cell.episodeDateLabel!.text = currentPodcast.podcastDate
        
        return cell
    }
    
    
    //MARK: - XML Methods
    
    
    
    func refreshData() {
        podcastTableView.reloadData()
        print("Reloaded Table View")
    }
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xmlManager.refreshPodcasts()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshData", name: "receivedPodcastData", object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

