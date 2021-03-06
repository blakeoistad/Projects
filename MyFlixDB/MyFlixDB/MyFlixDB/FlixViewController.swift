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
        let cell = tableView.dequeueReusableCellWithIdentifier("flickCell", forIndexPath: indexPath) as! FlixTableViewCell
        cell.accessoryType = .DisclosureIndicator
        if selectedGenre == "Horror" {
            let currentFlick = dataManager.horrorArray[indexPath.row]
            cell.flickTitleLabel.text = currentFlick.flickTitle
            cell.flickReleaseDateLabel.text = String(currentFlick.flickReleaseDate)
            cell.flickDirectorLabel.text = "Directed by \(currentFlick.flickDirector)"
        } else if selectedGenre == "Action-Adventure" {
            let currentFlick = dataManager.actionAdventureArray[indexPath.row]
            cell.flickTitleLabel.text = currentFlick.flickTitle
            cell.flickReleaseDateLabel.text = String(currentFlick.flickReleaseDate)
            cell.flickDirectorLabel.text = "Directed by \(currentFlick.flickDirector)"
        } else if selectedGenre == "Fantasy-Animation" {
            let currentFlick = dataManager.fantasyAnimationArray[indexPath.row]
            cell.flickTitleLabel.text = currentFlick.flickTitle
            cell.flickReleaseDateLabel.text = String(currentFlick.flickReleaseDate)
            cell.flickDirectorLabel.text = "Directed by \(currentFlick.flickDirector)"
        } else if selectedGenre == "Documentary" {
            let currentFlick = dataManager.documentaryArray[indexPath.row]
            cell.flickTitleLabel.text = currentFlick.flickTitle
            cell.flickReleaseDateLabel.text = String(currentFlick.flickReleaseDate)
            cell.flickDirectorLabel.text = "Directed by \(currentFlick.flickDirector)"
        } else if selectedGenre == "Drama" {
            let currentFlick = dataManager.dramaArray[indexPath.row]
            cell.flickTitleLabel.text = currentFlick.flickTitle
            cell.flickReleaseDateLabel.text = String(currentFlick.flickReleaseDate)
            cell.flickDirectorLabel.text = "Directed by \(currentFlick.flickDirector)"
        } else if selectedGenre == "Comedy" {
            let currentFlick = dataManager.comedyArray[indexPath.row]
            cell.flickTitleLabel.text = currentFlick.flickTitle
            cell.flickReleaseDateLabel.text = String(currentFlick.flickReleaseDate)
            cell.flickDirectorLabel.text = "Directed by \(currentFlick.flickDirector)"
        } else if selectedGenre == "Sci-Fi" {
            let currentFlick = dataManager.scifiArray[indexPath.row]
            cell.flickTitleLabel.text = currentFlick.flickTitle
            cell.flickReleaseDateLabel.text = String(currentFlick.flickReleaseDate)
            cell.flickDirectorLabel.text = "Directed by \(currentFlick.flickDirector)"
        } else if selectedGenre == "Mystery-Thriller" {
            let currentFlick = dataManager.mysteryThrillerArray[indexPath.row]
            cell.flickTitleLabel.text = currentFlick.flickTitle
            cell.flickReleaseDateLabel.text = String(currentFlick.flickReleaseDate)
            cell.flickDirectorLabel.text = "Directed by \(currentFlick.flickDirector)"
        }
        return cell
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destController = segue.destinationViewController as! FlickViewController
        let indexPath = genreTitlesTableView.indexPathForCell(sender as! FlixTableViewCell)
        
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
                    genreTitlesTableView.reloadData()
                    
                } else if selectedGenre == "Action-Adventure" {
                    let flickToDelete = dataManager.actionAdventureArray[indexPath.row]
                    print("Deleting: \(flickToDelete.flickTitle)")
                    dataManager.actionAdventureArray.removeAtIndex(indexPath.row)
                    dataManager.appDelegate.managedObjectContext.deleteObject(flickToDelete)
                    dataManager.fetchFlicks()
                    genreTitlesTableView.reloadData()
                } else if selectedGenre == "Fantasy-Animation" {
                    let flickToDelete = dataManager.fantasyAnimationArray[indexPath.row]
                    print("Deleting: \(flickToDelete.flickTitle)")
                    dataManager.fantasyAnimationArray.removeAtIndex(indexPath.row)
                    dataManager.appDelegate.managedObjectContext.deleteObject(flickToDelete)
                    dataManager.fetchFlicks()
                    genreTitlesTableView.reloadData()
                } else if selectedGenre == "Documentary" {
                    let flickToDelete = dataManager.documentaryArray[indexPath.row]
                    print("Deleting: \(flickToDelete.flickTitle)")
                    dataManager.documentaryArray.removeAtIndex(indexPath.row)
                    dataManager.appDelegate.managedObjectContext.deleteObject(flickToDelete)
                    dataManager.fetchFlicks()
                    genreTitlesTableView.reloadData()
                } else if selectedGenre == "Drama" {
                    let flickToDelete = dataManager.dramaArray[indexPath.row]
                    print("Deleting: \(flickToDelete.flickTitle)")
                    dataManager.dramaArray.removeAtIndex(indexPath.row)
                    dataManager.appDelegate.managedObjectContext.deleteObject(flickToDelete)
                    dataManager.fetchFlicks()
                    genreTitlesTableView.reloadData()
                } else if selectedGenre == "Comedy" {
                    let flickToDelete = dataManager.comedyArray[indexPath.row]
                    print("Deleting: \(flickToDelete.flickTitle)")
                    dataManager.comedyArray.removeAtIndex(indexPath.row)
                    dataManager.appDelegate.managedObjectContext.deleteObject(flickToDelete)
                    dataManager.fetchFlicks()
                    genreTitlesTableView.reloadData()
                } else if selectedGenre == "Sci-Fi" {
                    let flickToDelete = dataManager.scifiArray[indexPath.row]
                    print("Deleting: \(flickToDelete.flickTitle)")
                    dataManager.scifiArray.removeAtIndex(indexPath.row)
                    dataManager.appDelegate.managedObjectContext.deleteObject(flickToDelete)
                    dataManager.fetchFlicks()
                    genreTitlesTableView.reloadData()
                } else {
                        let flickToDelete = dataManager.mysteryThrillerArray[indexPath.row]
                        print("Deleting: \(flickToDelete.flickTitle)")
                        dataManager.mysteryThrillerArray.removeAtIndex(indexPath.row)
                        dataManager.appDelegate.managedObjectContext.deleteObject(flickToDelete)
                        dataManager.fetchFlicks()
                        genreTitlesTableView.reloadData()
                }
                
                
            }
    }
    
    
    //MARK: - Interactivity Methods
    
    @IBAction func editButtonPressed(sender: UIBarButtonItem) {
        print("\n-FlixVC-\nEdit Button Pressed")
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
