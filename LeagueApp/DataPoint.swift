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
    
    private var internalDate: Date
    private var internalTier: Tier
    private var internalLp: Int
    
    public var date: Date {
        return internalDate
    }
    
    public var tier: Tier {
        return internalTier
    }
    
    public var lp: Int {
        return internalLp
    }
    
    init(date: Date, tier: Tier, lp: Int) {
        self.internalDate = date
        self.internalTier = tier
        self.internalLp = lp
    }
    
    //MARK: CustomStringConvertible
    
    override var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        let formattedDate = dateFormatter.string(from: date)
        return "(Date: \(formattedDate), Tier: \(tier), LP: \(lp))"
    }
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("dataPoint")
    
    //MARK: Property Keys
    
    struct PropertyKey {
        static let date = "date"
        static let tier = "tier"
        static let lp = "lp"
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: PropertyKey.date)
        aCoder.encode(tier, forKey: PropertyKey.tier)
        aCoder.encode(lp, forKey: PropertyKey.lp)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // All properties are required. If we cannot decode any, the initializer should fail.
        guard let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? Date else {
            print("Unable to decode the date for a DataPoint object.")
            return nil
        }
        guard let tier = aDecoder.decodeObject(forKey: PropertyKey.tier) as? Tier else {
            print("Unable to decode the tier for a DataPoint object.")
            return nil
        }
        //Swift 3 bug with decodeObject on Ints. decodeObject returns nil every time, even though decodeInteger returns the Int.
        let lp = aDecoder.decodeObject(forKey: PropertyKey.lp) as? Int ?? aDecoder.decodeInteger(forKey: PropertyKey.lp)
        
        // Must call designated initializer.
        self.init(date: date, tier: tier, lp: lp)
    }
}
