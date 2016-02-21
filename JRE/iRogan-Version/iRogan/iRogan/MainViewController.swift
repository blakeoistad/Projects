//
//  MainViewController.swift
//  iRogan
//
//  Created by Blake Oistad on 12/6/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    // MARK: - Properties
    
    var networkManager = NetworkManager.sharedInstance
    var dataManager = DataManager.sharedInstance
    var feedManager = FeedManager.sharedInstance
    @IBOutlet weak var episodesTableView: UITableView!
    @IBOutlet weak var episodesSearchBar: UISearchBar!
    
    // MARK: - Table View Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.filteredEpisodeArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! EpisodeTableViewCell
        let currentEpisode = dataManager.filteredEpisodeArray[indexPath.row]
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        cell.episodeDateLabel.text = formatter.stringFromDate(currentEpisode.episodeDate)
        cell.episodeDateLabel.font = UIFont(name: "DIN Alternate", size: 15)
        cell.episodeNumberLabel.text = currentEpisode.episodeNumber
        cell.episodeNumberLabel.font = UIFont(name: "DIN Alternate", size: 35)
        cell.episodeGuestNameLabel.text = currentEpisode.episodeGuests
        cell.episodeGuestNameLabel.font = UIFont(name: "DIN Alternate", size: 33)
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToPlayer" {
            let destController = segue.destinationViewController as! PlayerViewController
            if let indexPath = episodesTableView.indexPathForSelectedRow {
//                let indexPath = episodesTableView.indexPathForSelectedRow!
                let selectedEpisode = dataManager.filteredEpisodeArray[indexPath.row]
                destController.selectedEpisode = selectedEpisode
                episodesTableView.deselectRowAtIndexPath(indexPath, animated: true)
            } else {
                print("Cell appears to be nil")
            }
        }
    }
    
    // MARK: - Search Methods
    
    @IBAction func searchBarButtonPressed(sender: UIBarButtonItem) {
        if episodesSearchBar.hidden == false {
            episodesSearchBar.hidden = true
        } else {
            episodesSearchBar.hidden = false
        }
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if episodesSearchBar.text != nil {
            filterEpisodesForSearchText(episodesSearchBar.text!)
        } else {
            dataManager.filteredEpisodeArray = dataManager.episodeArray
        }
        episodesTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        dataManager.filteredEpisodeArray = dataManager.episodeArray
        episodesTableView.reloadData()
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        searchBar.text = ""
    }
    
    func filterEpisodesForSearchText(searchText: String) {
        dataManager.filteredEpisodeArray = dataManager.episodeArray.filter({ (episode: Episode) -> Bool in
            let stringMatch = episode.episodeGuests.localizedCaseInsensitiveContainsString(searchText) || episode.episodeNumber.localizedCaseInsensitiveContainsString(searchText)
            return stringMatch
        })
    }
    
    // MARK: - Data Flow Methods
    
    func refreshData() {
        episodesTableView.reloadData()
        if dataManager.filteredEpisodeArray.count != 0 {
            print("\(dataManager.filteredEpisodeArray.count) Episodes on launch")
        }
    }
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        feedManager.refreshEpisodes()
        dataManager.updateEpisodeArray()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshData", name: "callToRefreshData", object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
