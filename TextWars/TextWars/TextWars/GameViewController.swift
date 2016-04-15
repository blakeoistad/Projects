//
//  GameViewController.swift
//  TextWars
//
//  Created by Blake Oistad on 4/12/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UITextFieldDelegate {

    //MARK: - Properties
    
    @IBOutlet weak var stringToMatchLabel: UILabel!
    @IBOutlet weak var textEntryTextField: UITextField!
    @IBOutlet weak var timerLabel: UILabel!
    
    var stringToMatch = "So, what are you doing later?"
    var timerCount = 0.0
    
    //MARK: - Input Methods
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("Started typing!")
        timerLabel.text = String(timerCount)
        timerCount += 0.1
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textEntryTextField.text == stringToMatchLabel.text {
            print("Match!")
        } else {
            print("Misfire!")
        }
        return true
    }
    

    
    //MARK: - Life Cylce Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textEntryTextField.delegate = self
        
        stringToMatchLabel.text = stringToMatch

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
