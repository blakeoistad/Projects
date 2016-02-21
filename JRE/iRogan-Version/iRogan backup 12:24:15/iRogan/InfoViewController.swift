//
//  InfoViewController.swift
//  iRogan
//
//  Created by Blake Oistad on 12/6/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var createdByLabel: UILabel!
    @IBOutlet weak var akaCodeboyLabel: UILabel!
    
    
    func setUpAppearance() {
        UILabel.appearance().font = UIFont(name: "DIN Alternate", size: 25)
        UITextView.appearance().font = UIFont(name: "DIN Alternate", size: 15)
    }
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAppearance()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
