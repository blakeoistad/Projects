//
//  FlixViewController.swift
//  MyFlixDB
//
//  Created by Blake Oistad on 3/28/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//

import UIKit

class FlixViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    //MARK: - Properties
    var dataManager = DataManager.sharedInstance
    var selectedGenre: String?
    
    @IBOutlet weak var genreTitlesTableView: UITableView!
    
    //MARK: - Table View Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedGenre == "Horror" {
            return dataManager.horrorArray.count
        } else if selectedGenre == "Action-Adventure" {
            return dataManager.actionAdventureArray.count
        } else if selectedGenre == "Fantasy-Animation" {
            return dataManager.fantasyAnimationArray.count
        } else if selectedGenre == "Documentary" {
            return dataManager.documentaryArray.count
        } else if selectedGenre == "Drama" {
            return dataManager.dramaArray.count
        } else if selectedGenre == "Comedy" {
            return dataManager.comedyArray.count
        } else if selectedGenre == "Sci-Fi" {
            return dataManager.scifiArray.count
        } else {
            return dataManager.mysteryThrillerArray.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("flickCell", forIndexPath: indexPath)
        if selectedGenre == "Horror" {
            cell.textLabel!.text = dataManager.horrorArray[indexPath.row].flickTitle
        } else if selectedGenre == "Action-Adventure" {
            cell.textLabel!.text = dataManager.actionAdventureArray[indexPath.row].flickTitle
        } else if selectedGenre == "Fantasy-Animation" {
            cell.textLabel!.text = dataManager.fantasyAnimationArray[indexPath.row].flickTitle
        } else if selectedGenre == "Documentary" {
            cell.textLabel!.text = dataManager.documentaryArray[indexPath.row].flickTitle
        } else if selectedGenre == "Drama" {
            cell.textLabel!.text = dataManager.dramaArray[indexPath.row].flickTitle
        } else if selectedGenre == "Comedy" {
            cell.textLabel!.text = dataManager.comedyArray[indexPath.row].flickTitle
        } else if selectedGenre == "Sci-Fi" {
            cell.textLabel!.text = dataManager.scifiArray[indexPath.row].flickTitle
        } else {
            cell.textLabel!.text = dataManager.mysteryThrillerArray[indexPath.row].flickTitle
        }
        return cell
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destController = segue.destinationViewController as! FlickViewController
        let indexPath = genreTitlesTableView.indexPathForCell(sender as! UITableViewCell)
        
        if selectedGenre == "Horror" {
            let selectedFlick = dataManager.horrorArray[(indexPath?.row)!]
            destController.selectedFlick = selectedFlick
        } else if selectedGenre == "Action-Adventure" {
            let selectedFlick = dataManager.actionAdventureArray[(indexPath?.row)!]
            destController.selectedFlick = selectedFlick
        } else if selectedGenre == "Fantasy-Animation" {
            let selectedFlick = dataManager.fantasyAnimationArray[(indexPath?.row)!]
            destController.selectedFlick = selectedFlick
        } else if selectedGenre == "Documentary" {
            let selectedFlick = dataManager.documentaryArray[(indexPath?.row)!]
            destController.selectedFlick = selectedFlick
        } else if selectedGenre == "Drama" {
            let selectedFlick = dataManager.dramaArray[(indexPath?.row)!]
            destController.selectedFlick = selectedFlick
        } else if selectedGenre == "Comedy" {
            let selectedFlick = dataManager.comedyArray[(indexPath?.row)!]
            destController.selectedFlick = selectedFlick
        } else if selectedGenre == "Sci-Fi" {
            let selectedFlick = dataManager.scifiArray[(indexPath?.row)!]
            destController.selectedFlick = selectedFlick
        } else {
            let selectedFlick = dataManager.mysteryThrillerArray[(indexPath?.row)!]
            destController.selectedFlick = selectedFlick
        }
        genreTitlesTableView.deselectRowAtIndexPath(indexPath!, animated: true)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
            if editingStyle == .Delete {
                
                if selectedGenre == "Horror" {
                    let flickToDelete = dataManager.horrorArray[indexPath.row]
                    print("Deleting: \(flickToDelete.flickTitle)")
                    dataManager.horrorArray.removeAtIndex(indexPath.row)
                    dataManager.appDelegate.managedObjectContext.deleteObject(flickToDelete)
                    dataManager.fetchFlicks()
                    dataManager.filterGenreArrays()
                    genreTitlesTableView.reloadData()
                    
                }
                
                
            }
    }
    
    
    //MARK: - Interactivity Methods
    
    @IBAction func editButtonPressed(sender: UIBarButtonItem) {
        print("Edit Button Pressed")
        genreTitlesTableView.editing = !genreTitlesTableView.editing
    }
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedGenre
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
