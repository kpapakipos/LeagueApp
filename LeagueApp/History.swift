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
    
    private var dataPoints: [DataPoint]
    
    override init() {
        self.dataPoints = [DataPoint]()
        //TESTING:
        super.init()
        self.appendDataPoint(DataPoint(date: Date(), tier: Tier(league: "Wood", division: 64), lp: 69))
    }
    
    init(dataPoints: [DataPoint]) {
        self.dataPoints = dataPoints
    }
    
    public func appendDataPoint(_ point: DataPoint) {
        dataPoints.append(point)
    }
    
    public func getDataPoints() -> [DataPoint] {
        return dataPoints
    }
    
    //MARK: CustomStringConvertible
    
    override var description: String {
        var buildingDesc = "["
        guard dataPoints.count > 0 else {
            print("History is empty")
            return "History is empty"
        }
        for dataPoint in dataPoints {
            buildingDesc.append(dataPoint.description)
            buildingDesc.append(", ")
        }
        let last2 = buildingDesc.substring(from: buildingDesc.index(buildingDesc.endIndex, offsetBy: -2))
        if last2 == ", " {
            buildingDesc = String(buildingDesc.characters.dropLast(2))
        }
        buildingDesc.append("]")
        return buildingDesc
    }
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("history")
    
    //MARK: Property Keys
    
    struct PropertyKey {
        static let dataPoints = "dataPoints"
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
