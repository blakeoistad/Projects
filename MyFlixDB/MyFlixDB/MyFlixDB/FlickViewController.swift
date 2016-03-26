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
    
    @IBOutlet weak var flickTitleLabel: UILabel!
    @IBOutlet weak var flickDirectorLabel: UILabel!
    @IBOutlet weak var flickSummaryTextView: UITextView!
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(selectedFlick!.flickTitle)")
        self.title = selectedFlick!.flickTitle
        flickTitleLabel.text = selectedFlick!.flickTitle
        flickDirectorLabel.text = selectedFlick!.flickDirector
        flickSummaryTextView.text = selectedFlick!.flickSummary
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
