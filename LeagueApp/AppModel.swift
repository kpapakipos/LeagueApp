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
    
    //MARK: Constants
    
    static let apiKey = "RGAPI-98f4a4c0-3c24-4c4a-b573-ea83b38c32ce"
    static let trackedSummonersLimit = 5
    
    //MARK: Variables
    
    static var trackedSummoners = [Summoner]()
    
    static func trackSummoner(summonerId: UInt64, name: String) {
        guard trackedSummoners.count <= trackedSummonersLimit else {
            UIApplication.topViewController()?.simpleAlert(title: "Error", message: "You can only track \(trackedSummonersLimit) summoners")
            return
        }
        for summoner in trackedSummoners {
            if summonerId == summoner.id {
                return
            }
        }
        trackedSummoners.append(Summoner(id: summonerId, name: name))
        saveTrackedSummoners()
    }
    
    static func saveTrackedSummoners() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(trackedSummoners, toFile: Summoner.ArchiveURL.path)
        if isSuccessfulSave {
            print("Tracked summoners successfully saved: \(trackedSummoners)")
        } else {
            print("Failed to save tracked summoners")
        }
    }
    
    static func loadTrackedSummoners(completion: () -> Void) {
        guard let persistedSummoners = NSKeyedUnarchiver.unarchiveObject(withFile: Summoner.ArchiveURL.path) as? [Summoner] else {
            print("Failed to load persisted tracked summoners")
            return
        }
        print("Tracked summoners successfully loaded: \(persistedSummoners)")
        trackedSummoners = persistedSummoners
        completion()
    }
    
    //TODO: Setup a singleton timer that polls the Riot API daily, and then records the data points in each summoner's history
    
    static func setupPollTimer() {
        
    }
}
