//
//  PlayerManager.swift
//  iRogan
//
//  Created by Blake Oistad on 12/14/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerManager: NSObject {

    static let sharedInstance = PlayerManager()
    
    //MARK: - Properties
    
    var audioPlayer: AVPlayer!
    
}
