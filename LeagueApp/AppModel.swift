//
//  AppModel.swift
//  LeagueApp
//
//  Created by Keegan Papakipos on 9/13/17.
//  Copyright © 2017 Keegan Papakipos. All rights reserved.
//

import Foundation

class AppModel {
    
    static var trackedSummoners = [Summoner]()
    
    static func trackSummoner(summonerId: UInt64) {
        for summoner in trackedSummoners {
            if summonerId == summoner.id {
                return
            }
        }
        trackedSummoners.append(Summoner(id: summonerId))
    }
    
    /*static func saveTrackedSummoners() {
        let defaults = UserDefaults.standard
        var trackedSummonersNSNumbers = [NSNumber]()
        for trackedSummoner in trackedSummoners {
            trackedSummonersNSNumbers.append(NSNumber(value: trackedSummoner.id!))
        }
        defaults.set(trackedSummonersNSNumbers, forKey: PropertyKey.trackedSummoners)
    }
    
    static func loadTrackedSummoners() {
        let defaults = UserDefaults.standard
        guard let persistedSummonersNSNumbers = defaults.object(forKey: PropertyKey.trackedSummoners) as? [NSNumber] else {
            print("could not load persisted tracked summoners")
            return
        }
        var persistedSummoners = [UInt64]()
        for persistedSummonerIdNSNumber in persistedSummonersNSNumbers {
            persistedSummoners.append(persistedSummonerIdNSNumber.uint64Value)
        }
        trackedSummoners = persistedSummoners
    }*/
}

//MARK: Properties

struct PropertyKey {
    static let trackedSummoners = "trackedSummoners"
}
