//
//  LocationsManager.swift
//  SimpleWeather
//
//  Created by Blake Oistad on 4/11/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//

import UIKit
import CoreLocation

class LocationsManager: NSObject, CLLocationManagerDelegate {

    //MARK: - Properties
    
    static let sharedInstance = LocationsManager()
    
    var dataManager = DataManager.sharedInstance
    var locationManager = CLLocationManager()
    var userLocationCoordinates = CLLocationCoordinate2D()
    
    //MARK: - Location Methods
    
}
