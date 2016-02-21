//
//  BrowseViewController.swift
//  jreCast
//
//  Created by Blake Oistad on 11/24/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    
    //MARK: - Properties
    
    var dataManager = DataManager.sharedInstance
    var feedManager = FeedManager.sharedInstance
    @IBOutlet weak var episodesCollectionView: UICollectionView!
    @IBOutlet weak var episodesSearchBar: UISearchBar!
    
    
    //MARK: - Collection View Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.filteredEpisodeArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("leadingCell", forIndexPath: indexPath) as! EpisodeCollectionViewCell
        let currentEpisode = dataManager.filteredEpisodeArray[indexPath.row]
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        cell.episodeDateLabel.text = formatter.stringFromDate(currentEpisode.episodeDate!)
        cell.episodeNumberLabel.text = currentEpisode.episodeNumber
        cell.episodeGuestNameLabel.text = currentEpisode.episodeGuestsString
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.bounds.width, 200)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToPlayer" {
            let destController = segue.destinationViewController as! PlayerViewController
            let indexPath = episodesCollectionView.indexPathForCell(sender as! EpisodeCollectionViewCell)
            let selectedEpisode = dataManager.filteredEpisodeArray[(indexPath?.row)!]
            destController.selectedEpisode = selectedEpisode
            episodesCollectionView.deselectItemAtIndexPath(indexPath!, animated: true)
        }
    }
    
    //MARK: - Search Methods
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        print("Text Being Edited")
        searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if episodesSearchBar.text != nil {
            filterEpisodesForSearchText(episodesSearchBar.text!)
        } else {
            print("No Results Found")
            dataManager.filteredEpisodeArray = dataManager.episodeArray
        }
        episodesCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        dataManager.filteredEpisodeArray = dataManager.episodeArray
        episodesCollectionView.reloadData()
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        searchBar.text = ""
    }
    
    func filterEpisodesForSearchText(searchText: String) {
        dataManager.filteredEpisodeArray = dataManager.episodeArray.filter({ (episode: Episode) -> Bool in
            if let guestString = episode.episodeGuestsString {
                let stringMatch = guestString.localizedCaseInsensitiveContainsString(searchText)
                return stringMatch
            }
            return false
        })
    }
    
    //MARK: - XML Methods
    
    func refreshData() {
        episodesCollectionView.reloadData()
        if dataManager.filteredEpisodeArray.count != 0 {
            print("\(dataManager.filteredEpisodeArray.count) Episodes on launch")
        } else {
        }
    }
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedManager.refreshEpisodes()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshData", name: "callToRefreshData", object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
