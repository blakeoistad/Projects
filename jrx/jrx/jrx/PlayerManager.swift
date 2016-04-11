//
//  PlayerManager.swift
//  jrx
//
//  Created by Blake Oistad on 4/11/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerManager: NSObject {

    static let sharedInstance = PlayerManager()
    
    //MARK: - Properties
    
    var audioPlayer: AVPlayer!
    
}
