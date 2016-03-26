//
//  BrowseViewController.swift
//  MyFlixDB
//
//  Created by Blake Oistad on 2/21/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: - Properties
    
    var dataManager = DataManager.sharedInstance
    
    @IBOutlet weak var browseTableView: UITableView!
    
    //MARK: - Interactivity Methods
    
    @IBAction func newFlickButtonPressed(sender: UIBarButtonItem) {
        print("New Flick button pressed")
    }
    
    //MARK: - Table View Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.genresArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel!.text = dataManager.genresArray[indexPath.row]
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueAddFlick" {
            _ = segue.destinationViewController as! NewFlickViewController
        } else {
            let destController = segue.destinationViewController as! GenreViewController
            let indexPath = browseTableView.indexPathForCell(sender as! UITableViewCell)
            let selectedGenre = dataManager.genresArray[(indexPath?.row)!]
            destController.selectedGenre = selectedGenre
            browseTableView.deselectRowAtIndexPath(indexPath!, animated: true)
        }
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        dataManager.tempAddRecords()
        
        dataManager.flicksArray = dataManager.fetchFlicks()!
        
        dataManager.filterGenreArrays()
        print("\(dataManager.genresArray.count) Genres in genreArray")
        print("\(dataManager.flicksArray.count) items in flicksArray")
        print("\(dataManager.comedyArray.count) items in comedyArray")
        print("\(dataManager.horrorArray.count) items in horrorArray, including \(dataManager.horrorArray.first!.flickTitle)")
        
        dataManager.getArrayDetails()
    }
    
    override func viewWillAppear(animated: Bool) {
        dataManager.filterGenreArrays()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
