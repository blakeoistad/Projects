//
//  NetworkManager.swift
//  SimpleWeather
//
//  Created by Blake Oistad on 4/11/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//

import UIKit
import ReachabilitySwift

class NetworkManager: NSObject {
    
    //MARK: - Properties
    
    static let sharedInstance = NetworkManager()
    var serverReach: Reachability?
    var serverAvailable = false
    
    //MARK: - Networking Methods
    
    func reachabilityChanged(note: NSNotification) {
        let reach = note.object as! Reachability
        serverAvailable = !(reach.currentReachabilityStatus == .NotReachable)
        if serverAvailable {
            print("NetworkManager:\n------------------Server Available")
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "networkConnected", object: nil))
        } else {
            print("NetworkManager:\n------------------Server Unavailable")
        }
    }
    
    //MARK: - Initialization
    
    override init() {
        super.init()
        print("NetworkManager:\n-Starting Network Manager...\n")
        
        do {
            serverReach = try Reachability.reachabilityForInternetConnection()
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: nil)
            do{
                try serverReach?.startNotifier()
            }catch{
                print("could not start reachability notifier")
            }
        } catch {
            print("Unable to create Reachability")
            return
        }
    }
    

}
