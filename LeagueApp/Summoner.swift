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
    
    private var internalId: UInt64
    private var internalName: String
    private var internalHistory: History
    
    public var id: UInt64 {
        return internalId
    }
    
    public var name: String {
        return internalName
    }
    
    public var history: History {
        return internalHistory
    }
    
    init(id: UInt64, name: String) {
        self.internalId = id
        self.internalName = name
        self.internalHistory = History()
    }
    
    init(id: UInt64, name: String, history: History) {
        self.internalId = id
        self.internalName = name
        self.internalHistory = history
    }
    
    public func recordNewDataPoint(_ point: DataPoint) {
        history.appendDataPoint(point)
    }
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("summoner")
    
    //MARK: Property Keys
    
    struct PropertyKey {
        static let id = "id"
        static let name = "name"
        static let history = "history"
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(NSNumber(value: id), forKey: PropertyKey.id)
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(history, forKey: PropertyKey.history)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // All properties are required. If we cannot decode any, the initializer should fail.
        guard let id = aDecoder.decodeObject(forKey: PropertyKey.id) as? NSNumber else {
            print("Unable to decode the id for a Summoner object.")
            return nil
        }
        
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            print("Unable to decode the name for a Summoner object.")
            return nil
        }
        
        guard let history = aDecoder.decodeObject(forKey: PropertyKey.history) as? History else {
            print("Unable to decode the history for a Summoner object.")
            return nil
        }
        
        // Must call designated initializer.
        self.init(id: id.uint64Value, name: name, history: history)
    }
}
