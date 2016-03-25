//
//  FlickViewController.swift
//  MyFlixDB
//
//  Created by Blake Oistad on 3/25/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//

import UIKit

class FlickViewController: UIViewController {

    //MARK: - Properties
    var selectedFlick: Flick?
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedFlick?.flickTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
