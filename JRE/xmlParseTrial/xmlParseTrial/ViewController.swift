//
//  ViewController.swift
//  xmlParseTrial
//
//  Created by Blake Oistad on 11/28/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Properties
    
    var xmlManager = XMLManager.sharedInstance
    
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL(string: xmlManager.feedURLString)
        xmlManager.startParsingWithContentsOfURL(url!)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

