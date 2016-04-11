//
//  MainViewController.swift
//  jrx
//
//  Created by Blake Oistad on 4/11/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - Properties
    
    var networkManager = NetworkManager.sharedInstance
    var feedManager = FeedManager.sharedInstance
    var dataManager = DataManager.sharedInstance
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
