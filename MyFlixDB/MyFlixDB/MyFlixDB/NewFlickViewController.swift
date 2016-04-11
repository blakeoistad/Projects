//
//  NewFlickViewController.swift
//  MyFlixDB
//
//  Created by Blake Oistad on 2/21/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//

import UIKit
import CoreData

class NewFlickViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UITextViewDelegate, UISearchBarDelegate {

    //MARK: - Properties
    var dataManager = DataManager.sharedInstance
    
    var currentFlick: Flick?
    var selectedGenre: String?
    var selectedYear: Int?
    var searchString: String?
    @IBOutlet weak var flickTitleTextField: UITextField!
    @IBOutlet weak var flickDirectorTextField: UITextField!
    @IBOutlet weak var flickGenrePickerView: UIPickerView!
    @IBOutlet weak var flickSummaryTextView: UITextView!
    @IBOutlet weak var flickReleaseDateTextField: UITextField!
    @IBOutlet weak var flickSearchBar: UISearchBar!
    
    //MARK: - Search Bar Methods
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if searchBar.text != "" {
            searchString = searchBar.text!
            if searchString!.containsString(" ") {
                let modifiedString = searchString!.stringByReplacingOccurrencesOfString(" ", withString: "+")
                print("\n-NewFlickVC-\nSearching OMDB for \(modifiedString)")
                dataManager.getDataFromServer(modifiedString)
            } else {
                print("\n-NewFlickVC-\nSearching OMDB for \(searchString)")
                dataManager.getDataFromServer(searchString!)
            }
        } else {
            print("Nothing in searchBar")
        }
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = false
        return true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    
    //MARK: - Picker View Methods
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return dataManager.genresArray.count
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return dataManager.genresArray[row]
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = dataManager.genresArray[pickerView.selectedRowInComponent(0)]
        selectedGenre = selectedValue
        print("\n-NewFlickVC-\nSelected: \(selectedGenre)")
        
    }
    
    //MARK: - Interactivity Methods
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if flickSummaryTextView.isFirstResponder() {
            flickSummaryTextView.resignFirstResponder()
        } else if flickTitleTextField.isFirstResponder() {
            flickTitleTextField.resignFirstResponder()
        } else if flickSummaryTextView.isFirstResponder() {
            flickSummaryTextView.resignFirstResponder()
        } else if flickDirectorTextField.isFirstResponder() {
            flickDirectorTextField.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    //MARK: - Data Flow Methods
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        print("\n-NewFlickVC-\nSave Button Pressed")
        
        if flickTitleTextField.text == "" {
            print("\n-NewFlickVC-\nOption 1")
            let alert = UIAlertController(title: "Empty Flick!", message: "Please enter a flick title and genre before saving your new flick!", preferredStyle: .Alert)
            let confirmAction = UIAlertAction(title: "Ok", style: .Default, handler: { (action) -> Void in
                print("\n-NewFlickVC-\nUser pressed OK")
            })
            alert.addAction(confirmAction)
            self.presentViewController(alert, animated: true) {
            }
        } else {
            print("\n-NewFlickVC-\nOption 2")
            let entityDescription: NSEntityDescription! = NSEntityDescription.entityForName("Flick", inManagedObjectContext: dataManager.appDelegate.managedObjectContext)
            currentFlick = Flick(entity: entityDescription, insertIntoManagedObjectContext: dataManager.appDelegate.managedObjectContext)
            currentFlick!.flickTitle = flickTitleTextField.text!
            currentFlick!.flickGenre = selectedGenre!
            currentFlick!.flickDirector = flickDirectorTextField.text!
            currentFlick!.flickReleaseDate = Int(flickReleaseDateTextField.text!)!
            currentFlick!.flickSummary = flickSummaryTextView.text!
            currentFlick!.flickDateEntered = NSDate()
            
            if selectedGenre == "Horror" {
                dataManager.updateHorrorArray(currentFlick!)
                dataManager.appDelegate.saveContext()
                navigationController!.popViewControllerAnimated(true)
            } else if selectedGenre == "Action-Adventure" {
                dataManager.updateActionAdventureArray(currentFlick!)
                dataManager.appDelegate.saveContext()
                navigationController!.popViewControllerAnimated(true)
            } else if selectedGenre == "Fantasy-Animation" {
                dataManager.updateFantasyAnimationArray(currentFlick!)
                dataManager.appDelegate.saveContext()
                navigationController!.popViewControllerAnimated(true)
            } else if selectedGenre == "Documentary" {
                dataManager.updateDocumentaryArray(currentFlick!)
                dataManager.appDelegate.saveContext()
                navigationController!.popViewControllerAnimated(true)
            } else if selectedGenre == "Drama" {
                dataManager.updateDramaArray(currentFlick!)
                dataManager.appDelegate.saveContext()
                navigationController!.popViewControllerAnimated(true)
            } else if selectedGenre == "Comedy" {
                dataManager.updateComedyArray(currentFlick!)
                dataManager.appDelegate.saveContext()
                navigationController!.popViewControllerAnimated(true)
            } else if selectedGenre == "Sci-Fi" {
                dataManager.updateSciFiArray(currentFlick!)
                dataManager.appDelegate.saveContext()
                navigationController!.popViewControllerAnimated(true)
            } else if selectedGenre == "Mystery-Thriller" {
                dataManager.updateMysteryThrillerArray(currentFlick!)
                dataManager.appDelegate.saveContext()
                navigationController!.popViewControllerAnimated(true)
                
            }
        }
    }
    
    func populateMovieData(notification: NSNotification) {
        let flickReceived = notification.object as! Flick
        let receivedTitle = flickReceived.flickTitle
        let flickYear = flickReceived.flickReleaseDate
        print("Received: \(receivedTitle)")
        
        let alert = UIAlertController(title: "Found \(receivedTitle)!", message: "If everything looks good, press Save!", preferredStyle: .Alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .Default, handler: { (action) -> Void in
            print("\n-NewFlickVC-\nUser pressed OK")
            self.flickSearchBar.resignFirstResponder()
        })
        
        alert.addAction(confirmAction)
        self.presentViewController(alert, animated: true) {
        }
        
        flickTitleTextField.text = flickReceived.flickTitle
        flickDirectorTextField.text = flickReceived.flickDirector
        flickSummaryTextView.text = flickReceived.flickSummary
        flickReleaseDateTextField.text = String(flickReceived.flickReleaseDate)
        
        if flickReceived.flickGenre == "Horror" {
            flickGenrePickerView.selectRow(0, inComponent: 0, animated: true)
        } else if flickReceived.flickGenre == "Action" || flickReceived.flickGenre == "Adventure" {
            flickGenrePickerView.selectRow(1, inComponent: 0, animated: true)
        } else if flickReceived.flickGenre == "Fantasy" || flickReceived.flickGenre == "Animation" {
            flickGenrePickerView.selectRow(2, inComponent: 0, animated: true)
        } else if flickReceived.flickGenre == "Documentary" {
            flickGenrePickerView.selectRow(3, inComponent: 0, animated: true)
        } else if flickReceived.flickGenre == "Drama" {
            flickGenrePickerView.selectRow(4, inComponent: 0, animated: true)
        } else if flickReceived.flickGenre == "Comedy" {
            flickGenrePickerView.selectRow(5, inComponent: 0, animated: true)
        } else if flickReceived.flickGenre == "Sci-Fi" {
            flickGenrePickerView.selectRow(6, inComponent: 0, animated: true)
        } else if flickReceived.flickGenre == "Mystery" || flickReceived.flickGenre == "Thriller" {
            flickGenrePickerView.selectRow(7, inComponent: 0, animated: true)
        }

    }
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "populateMovieData:", name: "newDataReceived", object: dataManager.flickToTransfer)
        
        flickGenrePickerView.dataSource = self
        flickGenrePickerView.delegate = self
        flickTitleTextField.delegate = self
        flickDirectorTextField.delegate = self
        flickSummaryTextView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
