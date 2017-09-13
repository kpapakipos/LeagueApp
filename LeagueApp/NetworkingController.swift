//
//  NetworkingController.swift
//  LeagueApp
//
//  Created by Keegan Papakipos on 9/13/17.
//  Copyright © 2017 Keegan Papakipos. All rights reserved.
//

import Foundation

class NetworkingController: NSObject {
    
    static func getSummonerCall(summonerName: String, callback: @escaping (UInt64) -> Void) {
        guard let encodedName = summonerName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            print("Could not encode summoner name.")
            return
        }
        let urlString = URL(string: "https://na1.api.riotgames.com/lol/summoner/v3/summoners/by-name/\(encodedName)?api_key=RGAPI-b597a009-b928-4e87-bf74-86cb658e6aeb")
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error)
                } else {
                    if let usableData = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: usableData)
                            print(json)
                            guard let summoner = json as? [String:Any] else {
                                print("Coult not cast json to [String:Any]")
                                return
                            }
                            callback((summoner["id"] as! NSNumber).uint64Value)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    static func getSummonerLeague(summonerId: UInt64) {
        let urlString = URL(string: "https://na1.api.riotgames.com/lol/league/v3/positions/by-summoner/\(summonerId)?api_key=RGAPI-b597a009-b928-4e87-bf74-86cb658e6aeb")
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error)
                } else {
                    if let usableData = data {
                        var json: Any
                        do {
                            json = try JSONSerialization.jsonObject(with: usableData)
                            print(json)
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
