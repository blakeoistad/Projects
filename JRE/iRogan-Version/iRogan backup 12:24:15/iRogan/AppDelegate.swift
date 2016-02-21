//
//  AppDelegate.swift
//  iRogan
//
//  Created by Blake Oistad on 12/6/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import CoreData
import MediaPlayer
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    // MARK: - Custom Methods
    
    func setUpAppearance() {
        UINavigationBar.appearance().tintColor = UIColor.lightOrangeColor()
        MPVolumeView.appearance().tintColor = UIColor.lightOrangeColor()
        UIBarButtonItem.appearance().tintColor = UIColor.lightOrangeColor()
        UIButton.appearance().tintColor = UIColor.lightOrangeColor()
        UILabel.appearance().textColor = UIColor.whiteColor()
        UILabel.appearance().font = UIFont(name: "DIN Alternate", size: 15)
        UISearchBar.appearance().tintColor = UIColor.lightOrangeColor()
    }
    
    func setUpAudio
    
    
    // MARK: - Life Cycle Methods
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setUpAppearance()
        
        let ok = AVAudioSession.sharedInstance().availableCategories.contains(AVAudioSessionCategoryAmbient)
        print(ok)
        _ = try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient, withOptions: [])
        
        NSNotificationCenter.defaultCenter().addObserverForName(AVAudioSessionInterruptionNotification, object: nil, queue: nil) { (n:NSNotification) in
            guard let why = n.userInfo?[AVAudioSessionInterruptionTypeKey] as? UInt
                else {return}
            guard let type = AVAudioSessionInterruptionType(rawValue: why)
                else {return}
            if type == .Began {
                print("interruption began:\n\(n.userInfo!)")
            } else {
                print("interruption ended:\n\(n.userInfo!)")
                guard let opt = n.userInfo![AVAudioSessionInterruptionOptionKey] as? UInt else {return}
                let opts = AVAudioSessionInterruptionOptions(rawValue: opt)
                if opts.contains(.ShouldResume) {
                    print("should resume")
                } else {
                    print("should not resume")
                }
            }
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName(
            AVAudioSessionSilenceSecondaryAudioHintNotification, object: nil, queue: nil) {
                (n:NSNotification) in
                guard let why = n.userInfo?[AVAudioSessionSilenceSecondaryAudioHintTypeKey] as? UInt else {return}
                guard let type = AVAudioSessionSilenceSecondaryAudioHintType(rawValue:why) else {return}
                if type == .Begin {
                    print("silence hint begin:\n\(n.userInfo!)")
                } else {
                    print("silence hint end:\n\(n.userInfo!)")
                }
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
        print("Application Entered Background")
    }

    func applicationWillEnterForeground(application: UIApplication) {
        print("Application Will Enter Foreground")
    }

    func applicationDidBecomeActive(application: UIApplication) {
        print("Application Did Become Active")
        _ = try? AVAudioSession.sharedInstance().setActive(true, withOptions: [])
    }

    func applicationWillTerminate(application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource("iRogan", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            var options = [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true]
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: options)
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

