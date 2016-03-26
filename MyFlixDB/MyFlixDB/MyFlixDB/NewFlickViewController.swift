//
//  NewFlickViewController.swift
//  MyFlixDB
//
//  Created by Blake Oistad on 2/21/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//

import UIKit

class NewFlickViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    //MARK: - Properties
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var dataManager = DataManager.sharedInstance
    
    var currentFlick: Flick?
    @IBOutlet weak var flickTitleTextField: UITextField!
    @IBOutlet weak var flickGenrePickerView: UIPickerView!
    
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
    
    //MARK: - Data Flow Methods
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        print("Save Button Pressed")
        
        currentFlick?.flickTitle = flickTitleTextField.text!
        currentFlick?.flickGenre = "Horror"
        appDelegate.saveContext()
        navigationController!.popViewControllerAnimated(true)
    }
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flickGenrePickerView.dataSource = self
        flickGenrePickerView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
