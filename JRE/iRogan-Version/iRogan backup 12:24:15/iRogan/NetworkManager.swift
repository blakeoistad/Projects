//
//  NetworkManager.swift
//  iRogan
//
//  Created by Blake Oistad on 12/6/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {

    static let sharedInstance = NetworkManager()
    
    var serverReach: Reachability?
    var serverAvailable = false
    
    func reachabilityChanged(note: NSNotification) {
        let reach = note.object as! Reachability
        serverAvailable = !(reach.currentReachabilityStatus().rawValue == NotReachable.rawValue)
        if serverAvailable {
            print("Changed: Server Available")
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "networkConnected", object: nil))
        } else {
            print("Changed: Server Not Available")
        }
        
        
    }
    
    override init() {
        super.init()
        print("Starting Network Manager")
        let feedManager = FeedManager.sharedInstance
        serverReach = Reachability(hostName: feedManager.feedURL)
        serverReach?.startNotifier()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: kReachabilityChangedNotification, object: nil)
    }
    
}
