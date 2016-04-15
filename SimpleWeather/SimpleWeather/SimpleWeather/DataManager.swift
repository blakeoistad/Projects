//
//  DataManager.swift
//  SimpleWeather
//
//  Created by Blake Oistad on 4/11/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    //MARK: - Properties
    
    static let sharedInstance = DataManager()

    var baseURLString = "api.forecast.io"
    var currentLoc = Locations()
    
    //MARK: - Data Flow Methods
    
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "getDataFromServer", name: "networkConnected", object: nil)
    }
    
    func parseWeatherData(data: NSData) {
        do {
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            let tempDictArray = jsonResult.objectForKey("currently") as! NSDictionary
            print("Results:->\(tempDictArray)")
            let newLoc = Locations()
            newLoc.locTemp = tempDictArray.objectForKey("temperature") as! NSNumber
            newLoc.locSummary = tempDictArray.objectForKey("summary") as! String
            
            print("\nDataManager:\n-Location Details:\nTemperature: \(newLoc.locTemp.stringValue)\nSummary: \(newLoc.locSummary)")
            dispatch_async(dispatch_get_main_queue()) {
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "parsedWeatherData", object: nil))
            }

        } catch {
            print("JSON Parsing Error")
        }
    }
    
    func getDataFromServer() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        defer {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        let url = NSURL(string: "https://\(baseURLString)/forecast/1c6466ee433871019969e4719519e4b9/37.512639,-78.498073")
        let urlRequest = NSURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 30.0)
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            if data != nil {
                print("\nGot Data!")
                self.parseWeatherData(data!)
            } else {
                print("\nNo Data")
            }
        }
        task.resume()
    }
    
}
