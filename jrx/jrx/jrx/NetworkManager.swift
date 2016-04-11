//
//  NetworkManager.swift
//  jrx
//
//  Created by Blake Oistad on 4/11/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//

import UIKit
import ReachabilitySwift

class NetworkManager: NSObject {

    static let sharedInstance = NetworkManager()
    
    //MARK: - Properties
    
    var serverReach: Reachability?
    var serverAvailable = false
    
    //MARK: - Networking Methods
    
    func reachabilityChanged(note: NSNotification) {
        let reach = note.object as! Reachability
        serverAvailable = !(reach.currentReachabilityStatus == .NotReachable)
        if serverAvailable {
            print("NetworkManager:\n------------------Server Available")
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
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: serverReach)
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
