//
//  Summoner.swift
//  LeagueApp
//
//  Created by Keegan Papakipos on 9/14/17.
//  Copyright © 2017 Keegan Papakipos. All rights reserved.
//

import Foundation

class Summoner: NSObject, NSCoding {
    
    //MARK: Properties
    
    var id: UInt64
    var history: History
    
    init(id: UInt64) {
        self.id = id
        self.history = History()
    }
    
    init(id: UInt64, history: History) {
        self.id = id
        self.history = history
    }
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("summoner")
    
    //MARK: Property Keys
    
    struct PropertyKey {
        static let id = "id"
        static let history = "history"
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(NSNumber(value: id), forKey: PropertyKey.id)
        aCoder.encode(history, forKey: PropertyKey.history)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The id and history are both required. If we cannot decode either, the initializer should fail.
        guard let id = aDecoder.decodeObject(forKey: PropertyKey.id) as? NSNumber else {
            print("Unable to decode the id for a Summoner object.")
            return nil
        }
        
        guard let history = aDecoder.decodeObject(forKey: PropertyKey.history) as? History else {
            print("Unable to decode the history for a Summoner object.")
            return nil
        }
        
        // Must call designated initializer.
        self.init(id: id.uint64Value, history: history)
    }
}
