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
    @IBOutlet weak var flickPosterImageView: UIImageView!
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\n-FlickVC-\nSelected: \(selectedFlick!.flickTitle)")
        print("Selected Flick URL: \(selectedFlick!.flickImgNamed)")
        self.title = ""
        flickTitleLabel.text = selectedFlick!.flickTitle
        flickDirectorLabel.text = selectedFlick!.flickDirector
        
        if selectedFlick!.flickReleaseDate == 0 {
            flickReleaseDateLabel.text = "Unknown"
        } else {
            flickReleaseDateLabel.text = selectedFlick!.flickReleaseDate.stringValue
        }
        
        flickSummaryTextView.text = selectedFlick!.flickSummary
        
        
        //MARK: - Temporary Poster Images
        
        if selectedFlick!.flickImgNamed != "" {
            print("Am I here")
            print("Selected Flick Image URL: \(selectedFlick!.flickImgNamed)")
            if let url = NSURL(string: selectedFlick!.flickImgNamed) {
                print("URL IS: \(url)")
                if let data = NSData(contentsOfURL: url) {
                    flickPosterImageView.image = UIImage(data: data)
                }
            } else {
                print("Poster appears nil")
            }
        } else if selectedFlick!.flickTitle == "A Beautiful Mind" {
            flickPosterImageView.image = UIImage(named: "aBeautifulMind")
        } else if selectedFlick!.flickTitle == "Dumb & Dumber" {
            flickPosterImageView.image = UIImage(named: "dumbAndDumber")
        } else if selectedFlick!.flickTitle == "Forgetting Sarah Marshall" {
            flickPosterImageView.image = UIImage(named: "forgettingSarahMarshall")
        } else if selectedFlick!.flickTitle == "Jurassic Park" {
            flickPosterImageView.image = UIImage(named: "jurassicPark")
        } else if selectedFlick!.flickTitle == "Knocked Up" {
            flickPosterImageView.image = UIImage(named: "knockedUp")
        } else if selectedFlick!.flickTitle == "Legend" {
            flickPosterImageView.image = UIImage(named: "legend")
        } else if selectedFlick!.flickTitle == "Leprechaun" {
            flickPosterImageView.image = UIImage(named: "leprechaun")
        } else if selectedFlick!.flickTitle == "Limelight" {
            flickPosterImageView.image = UIImage(named: "limelight")
        } else if selectedFlick!.flickTitle == "Sleuth" {
            flickPosterImageView.image = UIImage(named: "sleuth")
        } else {
            flickPosterImageView.image = nil
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
