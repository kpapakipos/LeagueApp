//
//  NetworkingController.swift
//  LeagueApp
//
//  Created by Keegan Papakipos on 9/13/17.
//  Copyright © 2017 Keegan Papakipos. All rights reserved.
//

import Foundation

class NetworkingController: NSObject {
    
    static func getSummoner(region: String, summonerName: String, completion: @escaping ([String:Any]) -> Void) {
        guard let encodedName = summonerName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            print("Could not encode summoner name.")
            return
        }
        let urlString = URL(string: "https://\(region).api.riotgames.com/lol/summoner/v3/summoners/by-name/\(encodedName)?api_key=RGAPI-b597a009-b928-4e87-bf74-86cb658e6aeb")
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error)
                } else {
                    if let usableData = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: usableData)
                            //print(json)
                            guard let properlyFormattedJson = json as? [String:Any] else {
                                print("Could not cast json to [String:Any]")
                                return
                            }
                            let status = properlyFormattedJson["status"] as? [String:Any]
                            guard status == nil else {
                                print("api returned status, indicating error. Status = \(status!)")
                                return
                            }
                            completion(properlyFormattedJson)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    static func getSummonerLeague(region: String, summonerId: UInt64, completion: @escaping ([[String:Any]]) -> Void) {
        let urlString = URL(string: "https://\(region).api.riotgames.com/lol/league/v3/positions/by-summoner/\(summonerId)?api_key=RGAPI-b597a009-b928-4e87-bf74-86cb658e6aeb")
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error)
                } else {
                    if let usableData = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: usableData)
                            //print(json)
                            if let jsonDictionary = json as? [String:Any] {
                                let status = jsonDictionary["status"]
                                guard status == nil else {
                                    print("api returned status, indicating error. Status = \(status!)")
                                    return
                                }
                                print("getSummonerLeague returned improperly formatted json- was not an array")
                                return
                            }
                            guard let properlyFormattedJson = json as? [[String:Any]] else {
                                print("Could not cast json to [[String:Any]]")
                                return
                            }
                            completion(properlyFormattedJson)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
