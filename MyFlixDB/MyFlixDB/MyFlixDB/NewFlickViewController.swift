//
//  NewFlickViewController.swift
//  MyFlixDB
//
//  Created by Blake Oistad on 2/21/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//

import UIKit

class NewFlickViewController: UIViewController {

    //MARK: - Properties
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    //MARK: - Data Flow Methods
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        print("Save Button Pressed")
    }
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
