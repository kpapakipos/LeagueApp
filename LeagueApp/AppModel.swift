//
//  AppModel.swift
//  LeagueApp
//
//  Created by Keegan Papakipos on 9/13/17.
//  Copyright © 2017 Keegan Papakipos. All rights reserved.
//

import Foundation
import UIKit

class AppModel {
    
    //MARK: Properties
    
    static var trackedSummoners = [Summoner]()
    
    static func trackSummoner(summonerId: UInt64) {
        for summoner in trackedSummoners {
            if summonerId == summoner.summonerId {
                return
            }
        }
        trackedSummoners.append(Summoner(id: summonerId))
    }
    
    static func saveTrackedSummoners() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(trackedSummoners, toFile: Summoner.ArchiveURL.path)
        if isSuccessfulSave {
            print("Tracked summoners successfully saved: \(trackedSummoners)")
        } else {
            print("Failed to save tracked summoners")
        }
    }
    
    static func loadTrackedSummoners() {
        guard let persistedSummoners = NSKeyedUnarchiver.unarchiveObject(withFile: Summoner.ArchiveURL.path) as? [Summoner] else {
            print("Failed to load persisted tracked summoners")
            return
        }
        print("Tracked summoners successfully loaded: \(persistedSummoners)")
        trackedSummoners = persistedSummoners
        
        //MARK: Testing
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 1)
            DispatchQueue.main.async {
                UIApplication.topViewController()?.simpleAlert(title: "Loaded Summoners", message: "\(AppModel.trackedSummoners)")
            }
        }
    }
    
    //TODO: Setup a singleton timer that polls the Riot API daily, and then records the data points in each summoner's history
    
    static func setupPollTimer() {
        
    }
}
