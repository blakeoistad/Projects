//
//  PlayerViewController.swift
//  iRogan
//
//  Created by Blake Oistad on 12/6/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import MediaPlayer

class PlayerViewController: UIViewController {
    
    // MARK: - Properties
    
    
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var trackProgressSlider: UISlider!
    @IBOutlet weak var volumeSlider: MPVolumeView!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var episodeDateLabel: UILabel!
    @IBOutlet weak var episodeGuestsLabel: UILabel!
    @IBOutlet weak var trackCurrentTimeLabel: UILabel!
    @IBOutlet weak var trackRemainingTimeLabel: UILabel!
    
    var dataManager = DataManager.sharedInstance
    var playerManager = PlayerManager.sharedInstance
    var selectedEpisode: Episode!
    var audioDurationInSeconds: Int64!
    var currentTimeInTrack = Float64()
    var numberOfTimeUpdates = 0
    
    // MARK: - Interactivity Methods
    
    @IBAction func playPauseButtonPressed(sender: UIButton) {
        print("Play/Pause Toggled")
        if playPauseButton.imageView!.image == UIImage(named: "playIcon") {
            playPauseButton.setImage((UIImage(named: "pauseIcon")), forState: .Normal)
            _ = try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, withOptions: [])
            playerManager.audioPlayer.play()
        } else {
            playPauseButton.setImage((UIImage(named: "playIcon")), forState: .Normal)
            playerManager.audioPlayer.pause()
        }
    }
    
    @IBAction func seekToTime(sender: UISlider) {
        let seekerValueInCMTime = CMTimeMake(Int64(trackProgressSlider.value), 1)
        playerManager.audioPlayer.seekToTime(seekerValueInCMTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero) { (finished) -> Void in
            if (finished) {
                print("Moved Track Position")
                self.updateTrackProgress(seekerValueInCMTime)
                self.playPauseButton.imageView!.image = UIImage(named: "pauseIcon")
                self.playerManager.audioPlayer.play()
            }
        }
    }
    
    @IBAction func minus15ButtonPressed() {
        print("Minus 15 Sec")
        if trackProgressSlider.value != 0 {
            let seekerValueInCMTime = CMTimeMake(Int64(trackProgressSlider.value), 1)
            let timeToSubtract = CMTimeMakeWithSeconds(-15, 1)
            let resultTime = CMTimeAdd(seekerValueInCMTime, timeToSubtract)
            playerManager.audioPlayer.seekToTime(resultTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero, completionHandler: { (finished) -> Void in
                if (finished) {
                    print("Rewind 15")
                    self.updateTrackProgress(resultTime)
                }
            })
        }
    }
    
    @IBAction func plus15ButtonPressed() {
        print("Plus 15 Sec")
        if trackProgressSlider.value != 0 {
            let seekerValueInCMTime = CMTimeMake(Int64(trackProgressSlider.value), 1)
            let timeToSubtract = CMTimeMakeWithSeconds(15, 1)
            let resultTime = CMTimeAdd(seekerValueInCMTime, timeToSubtract)
            playerManager.audioPlayer.seekToTime(resultTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero, completionHandler: { (finished) -> Void in
                if (finished) {
                    print("Forward 15")
                    self.updateTrackProgress(resultTime)
                }
            })
        }
    }
    
    @IBAction func shareButtonPressed(sender: UIBarButtonItem) {
        print("Share Button Pressed")
        
        let textToShare = "I'm listening to episode \(selectedEpisode!.episodeNumber) with \(selectedEpisode!.episodeGuests) on iRogan! #jre #iRogan #joerogan"
        print(textToShare)
        
        let objectsToShare = [textToShare]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func moreButtonPressed() {
        print("More Button Pressed")
    }
    
    // MARK: - Streaming Methods
    
    func updateTrackProgress(time: CMTime) {
        let currentTimeInSeconds = CMTimeGetSeconds(time)
        currentTimeInTrack = Float64(currentTimeInSeconds)
        print("Current Time: \(currentTimeInSeconds)")
        let curSeconds = Int(currentTimeInSeconds % 60)
        let curMinutes = Int(currentTimeInSeconds / 60) % 60
        let curHours = Int(currentTimeInSeconds / 3600)
        trackCurrentTimeLabel.text = String(format: "%.02d:%.02d:%02d", curHours, curMinutes, curSeconds)
        trackCurrentTimeLabel.font = UIFont(name: "DIN Alternate", size: 12)
        let timeRemainingInSeconds = audioDurationInSeconds - Int64(currentTimeInSeconds)
        let remSeconds = (timeRemainingInSeconds % 60)
        let remMinutes = (timeRemainingInSeconds / 60) % 60
        let remHours = (timeRemainingInSeconds / 3600)
        trackRemainingTimeLabel.text = String(format: "-%.02d:%.02d:%.02d", remHours, remMinutes, remSeconds)
        trackRemainingTimeLabel.font = UIFont(name: "DIN Alternate", size: 12)

        numberOfTimeUpdates++
        if numberOfTimeUpdates >= 50 {
            print("TRIS:\(timeRemainingInSeconds)")
            selectedEpisode.episodeTrackTime = NSNumber(double: currentTimeInSeconds)
//            let timeRemaining = CMTimeMake(Int64(timeRemainingInSeconds), 1)
            dataManager.saveTrackPlacement()
            numberOfTimeUpdates = 0
        }
    }
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let uSelectedEpisode = selectedEpisode {
            trackProgressSlider.setThumbImage(UIImage(named: "sliderThumb"), forState: .Normal)
            
            playPauseButton.setImage((UIImage(named: "playIcon")), forState: .Normal)
            let streamingURL: NSURL = NSURL(string: uSelectedEpisode.episodeAudioURL)!
            let asset = AVURLAsset(URL: streamingURL)
            audioDurationInSeconds = Int64(CMTimeGetSeconds(asset.duration))
            
            if let player = playerManager.audioPlayer {
                print("have player")
                player.pause()
            } else {
                print("no player")
            }
            
            playerManager.audioPlayer = AVPlayer(URL: streamingURL)
            let playerItem = AVPlayerItem(URL: streamingURL)
            playerManager.audioPlayer = AVPlayer(playerItem: playerItem)
            
            playerManager.audioPlayer.addPeriodicTimeObserverForInterval(CMTime(seconds: 0.1, preferredTimescale: 10), queue: dispatch_get_main_queue()) { (time) -> Void in
                self.trackProgressSlider.setValue(Float(self.currentTimeInTrack), animated: true)
                self.updateTrackProgress(time)
            }
            let doubleTrackTime = selectedEpisode.episodeTrackTime.doubleValue
            print("Double Track Time: \(doubleTrackTime)")
            let trackTime = CMTimeMake(Int64(doubleTrackTime), 1)
//            let trackTimeInSeconds = CMTimeGetSeconds(trackTime)
            
            print("Track Time: \(trackTime)")
            
            playerManager.audioPlayer.seekToTime(trackTime)

        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        episodeGuestsLabel.text = selectedEpisode.episodeGuests
        episodeGuestsLabel.font = UIFont(name: "DIN Alternate", size: 33)
        episodeNumberLabel.text = selectedEpisode.episodeNumber
        episodeNumberLabel.font = UIFont(name: "DIN Alternate", size: 38)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        episodeDateLabel.text = formatter.stringFromDate(selectedEpisode.episodeDate)
        episodeDateLabel.font = UIFont(name: "DIN Alternate", size: 16)
        trackProgressSlider.maximumValue = Float(audioDurationInSeconds)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
