//
//  NetworkManager.swift
//  xmlAGAIN
//
//  Created by Blake Oistad on 11/28/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {

    static let sharedInstance = NetworkManager()
    
    //MARK: - Properties
    
    var serverReach: Reachability?
    var serverAvailable = false
    
    //MARK: - Network Methods
    
    func reachabilityChanged(note: NSNotification) {
        let reach = note.object as! Reachability
        serverAvailable = !(reach.currentReachabilityStatus().rawValue == NotReachable.rawValue)
        if serverAvailable {
            print("Server Currently Available")
        } else {
            print("Server Currently Unavailable")
        }
    }
    
    override init() {
        super.init()
        print("Starting Network Manager")
        serverReach = Reachability(hostName: "google.com")
        serverReach?.startNotifier()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: kReachabilityChangedNotification, object: nil)
    }
    
}
