//
//  DataPoint.swift
//  LeagueApp
//
//  Created by Keegan Papakipos on 9/14/17.
//  Copyright © 2017 Keegan Papakipos. All rights reserved.
//

import Foundation

class DataPoint: NSObject, NSCoding {
    
    //MARK: Properties
    
    var date: Date
    var tier: String
    var LP: Int
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("dataPoint")
    
    //MARK: Property Keys
    
    struct PropertyKey {
        static let date = "date"
        static let tier = "tier"
        static let LP = "LP"
    }
    
    init(date: Date, tier: String, LP: Int) {
        self.date = date
        self.tier = tier
        self.LP = LP
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: PropertyKey.date)
        aCoder.encode(tier, forKey: PropertyKey.tier)
        aCoder.encode(LP, forKey: PropertyKey.LP)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // All properties are required. If we cannot decode any, the initializer should fail.
        guard let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? Date else {
            print("Unable to decode the date for a DataPoints object.")
            return nil
        }
        guard let tier = aDecoder.decodeObject(forKey: PropertyKey.tier) as? String else {
            print("Unable to decode the tier for a DataPoints object.")
            return nil
        }
        guard let LP = aDecoder.decodeObject(forKey: PropertyKey.LP) as? Int else {
            print("Unable to decode the date for a DataPoints object.")
            return nil
        }
        
        // Must call designated initializer.
        self.init(date: date, tier: tier, LP: LP)
    }
}
