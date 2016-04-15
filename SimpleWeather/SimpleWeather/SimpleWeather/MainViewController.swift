//
//  MainViewController.swift
//  SimpleWeather
//
//  Created by Blake Oistad on 4/11/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - Properties
    
    var networkManager = NetworkManager.sharedInstance
    var dataManager = DataManager.sharedInstance
    var locationManager = LocationsManager.sharedInstance
    
    //MARK: - View Methods
    
    func refreshView() {
        print("Got to refreshView")
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshView", name: "parsedWeatherData", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
