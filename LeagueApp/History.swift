//
//  History.swift
//  LeagueApp
//
//  Created by Keegan Papakipos on 9/14/17.
//  Copyright © 2017 Keegan Papakipos. All rights reserved.
//

import Foundation

class History: NSObject, NSCoding {
    
    //MARK: Properties
    
    var dataPoints: [DataPoint]
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("history")
    
    //MARK: Property Keys
    
    struct PropertyKey {
        static let dataPoints = "dataPoints"
    }
    
    override init() {
        self.dataPoints = [DataPoint]()
    }
    
    init(dataPoints: [DataPoint]) {
        self.dataPoints = dataPoints
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(dataPoints, forKey: PropertyKey.dataPoints)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The dataPoints are required. If we cannot decode them, the initializer should fail.
        guard let dataPoints = aDecoder.decodeObject(forKey: PropertyKey.dataPoints) as? [DataPoint] else {
            print("Unable to decode the dataPoints for a History object.")
            return nil
        }
        
        // Must call designated initializer.
        self.init(dataPoints: dataPoints)
    }
}
