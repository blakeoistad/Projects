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
        print("\n-BrowseVC-\nNew Flick button pressed")
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var rowHeight = Int(tableView.rowHeight)

        let screenHeight = Int(UIScreen.mainScreen().bounds.height)
        
        let genreCount = dataManager.genresArray.count
        
        let navBarHeight = Int(self.navigationController!.navigationBar.frame.size.height)
        
        let statusBarHeight = Int(UIApplication.sharedApplication().statusBarFrame.size.height)
        
        let topAreaHeight = navBarHeight + statusBarHeight
        
        let remainderSpace = screenHeight - topAreaHeight
        
        rowHeight = remainderSpace / genreCount
        
        return CGFloat(rowHeight)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueAddFlick" {
            _ = segue.destinationViewController as! NewFlickViewController
        } else {
            let destController = segue.destinationViewController as! FlixViewController
            let indexPath = browseTableView.indexPathForCell(sender as! UITableViewCell)
            let selectedGenre = dataManager.genresArray[(indexPath?.row)!]
            destController.selectedGenre = selectedGenre
            browseTableView.deselectRowAtIndexPath(indexPath!, animated: true)
        }
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for year in dataManager.yearsArray {
//            print("\n-BrowseVC-\n\(year)")
//        }
        
        for flick in dataManager.flicksArray {
            print("-BrowseVC-\nTitle: \(flick.flickTitle) \nReleased In: \(flick.flickReleaseDate) \nGenre: \(flick.flickGenre) \n")
        }
        

    }
    
    
    override func viewDidAppear(animated: Bool) {
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
