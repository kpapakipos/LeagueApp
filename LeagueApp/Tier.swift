//
//  Tier.swift
//  LeagueApp
//
//  Created by Keegan Papakipos on 9/15/17.
//  Copyright © 2017 Keegan Papakipos. All rights reserved.
//

import Foundation

class Tier: NSObject, NSCoding {
    
    private var privateLeague: String?
    private var privateDivision: Int?
    
    init(league: String, division: Int) {
        privateLeague = league
        privateDivision = division
    }
    
    //MARK: CustomStringConvertible
    
    override var description: String {
        return "Wood 17"
    }
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("dataPoint")
    
    //MARK: Property Keys
    
    struct PropertyKey {
        static let league = "league"
        static let division = "division"
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(privateLeague, forKey: PropertyKey.league)
        aCoder.encode(privateDivision, forKey: PropertyKey.division)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // All properties are required. If we cannot decode any, the initializer should fail.
        guard let league = aDecoder.decodeObject(forKey: PropertyKey.league) as? String else {
            print("Unable to decode the league for a Tier object.")
            return nil
        }
        //Bug with swift 3 and decodeObject on Ints requires this ugliness
        let division = aDecoder.decodeObject(forKey: PropertyKey.division) as? Int ?? aDecoder.decodeInteger(forKey: PropertyKey.division)
        
        // Must call designated initializer.
        self.init(league: league, division: division)
    }
}
