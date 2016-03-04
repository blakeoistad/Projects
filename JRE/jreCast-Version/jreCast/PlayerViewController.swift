//
//  PlayerViewController.swift
//  jreCast
//
//  Created by Blake Oistad on 11/24/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class PlayerViewController: UIViewController {

    //MARK: - Properties
    
    var dataManager = DataManager.sharedInstance
    
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet var volumeSlider: UISlider!
    @IBOutlet var episodeNumberLabel: UILabel!
    @IBOutlet var episodeDateLabel: UILabel!
    @IBOutlet var episodeGuestsLabel: UILabel!
    
    var audioPlayer: AVPlayer!
    var selectedEpisode: Episode?
    
    
    //MARK: - Interactivity Methods
    
    @IBAction func playPauseButtonPressed(sender: UIButton) {
        print("Play/Pause Toggled")
        if playPauseButton.imageView!.image == UIImage(named: "playIcon") {
            playPauseButton.setImage((UIImage(named: "pauseIcon")), forState: .Normal)
            let streamingURL:NSURL = NSURL(string: selectedEpisode!.episodeAudioURL!)!
             audioPlayer = AVPlayer(URL: streamingURL)
            audioPlayer.play()
            
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                print("AVAudioSession Category Playback OK")
                do {
                    try AVAudioSession.sharedInstance().setActive(true)
                    print("AVAudioSession is Active")
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        } else {
            playPauseButton.setImage((UIImage(named: "playIcon")), forState: .Normal)
            audioPlayer.pause()
        }
    }
    
    @IBAction func minus15ButtonPressed() {
        print("Minus 15 Sec")
    }
    
    @IBAction func plus15ButtonPressed() {
        print("Plus 15 Sec")
    }
    
    @IBAction func volumeSliderValueChanged() {
        print("Volume Slider Changed")
        audioPlayer.volume = volumeSlider.value
    }
    
    @IBAction func shareButtonPressed() {
        print("Share Button Pressed")
    }
    
    @IBAction func moreButtonPressed() {
        print("More Button Pressed")
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playPauseButton.setImage((UIImage(named: "playIcon")), forState: .Normal)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        episodeGuestsLabel.text = selectedEpisode!.episodeGuestsString
        episodeNumberLabel.text = selectedEpisode!.episodeNumber
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        episodeDateLabel.text = formatter.stringFromDate(selectedEpisode!.episodeDate!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
