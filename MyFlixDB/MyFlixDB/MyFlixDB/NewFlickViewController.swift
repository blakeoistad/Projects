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
    @IBOutlet weak var flickReleaseDatePickerView: UIPickerView!
    @IBOutlet weak var flickSummaryTextView: UITextView!
    @IBOutlet weak var flickSearchBar: UISearchBar!
    
    //MARK: - Search Bar Methods
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if searchBar.text != "" {
            searchString = searchBar.text!
            if searchString!.containsString(" ") {
                let modifiedString = searchString?.stringByReplacingOccurrencesOfString(" ", withString: "+")
                print("Searching OMDB for \(modifiedString)")
                dataManager.getDataFromServer(modifiedString!)
            } else {
                print("Searching OMDB for \(searchString)")
                dataManager.getDataFromServer(searchString!)
            }
        } else {
            print("Input a search or add your flick manually below")
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
        
        if pickerView == flickGenrePickerView {
            return dataManager.genresArray.count
        } else {
            return dataManager.yearsArray.count
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == flickGenrePickerView {
            return dataManager.genresArray[row]
        } else {
            return String(dataManager.yearsArray[row])
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == flickGenrePickerView {
            let selectedValue = dataManager.genresArray[pickerView.selectedRowInComponent(0)]
            selectedGenre = selectedValue
            print("Selected: \(selectedGenre)")
        } else {
            let selectedValue = dataManager.yearsArray[pickerView.selectedRowInComponent(0)]
            selectedYear = selectedValue
            print("Selected: \(selectedYear)")
        }
        
        
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
        print("Save Button Pressed")
        
        if flickTitleTextField.text == "" {
            print("Option 1")
            let alert = UIAlertController(title: "Empty Flick!", message: "Please enter a flick title and genre before saving your new flick!", preferredStyle: .Alert)
            let confirmAction = UIAlertAction(title: "Ok", style: .Default, handler: { (action) -> Void in
                print("User pressed OK")
            })
            alert.addAction(confirmAction)
            self.presentViewController(alert, animated: true) {
            }
        } else {
            print("Option 2")
            let entityDescription: NSEntityDescription! = NSEntityDescription.entityForName("Flick", inManagedObjectContext: dataManager.appDelegate.managedObjectContext)
            currentFlick = Flick(entity: entityDescription, insertIntoManagedObjectContext: dataManager.appDelegate.managedObjectContext)
            currentFlick!.flickTitle = flickTitleTextField.text!
            currentFlick!.flickGenre = selectedGenre!
            currentFlick!.flickDirector = flickDirectorTextField.text!
            currentFlick!.flickReleaseDate = selectedYear!
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
            } else {
                dataManager.updateMysteryThrillerArray(currentFlick!)
                dataManager.appDelegate.saveContext()
                navigationController!.popViewControllerAnimated(true)
                
            }
        }
    }
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flickGenrePickerView.dataSource = self
        flickGenrePickerView.delegate = self
        flickReleaseDatePickerView.dataSource = self
        flickReleaseDatePickerView.delegate = self
        flickTitleTextField.delegate = self
        flickDirectorTextField.delegate = self
        flickSummaryTextView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
