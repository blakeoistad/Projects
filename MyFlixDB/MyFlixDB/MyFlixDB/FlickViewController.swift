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
    @IBOutlet weak var flickReleaseDateLabel: UILabel!
    @IBOutlet weak var flickSummaryTextView: UITextView!
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Selected: \(selectedFlick!.flickTitle)")
        self.title = selectedFlick!.flickTitle
        flickTitleLabel.text = selectedFlick!.flickTitle
        flickDirectorLabel.text = selectedFlick!.flickDirector
        
        if selectedFlick!.flickReleaseDate == 0 {
            flickReleaseDateLabel.text = "Unknown"
        } else {
            flickReleaseDateLabel.text = selectedFlick!.flickReleaseDate.stringValue
        }
        
        flickSummaryTextView.text = selectedFlick!.flickSummary
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
