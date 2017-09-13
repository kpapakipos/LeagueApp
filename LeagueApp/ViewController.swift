//
//  ViewController.swift
//  LeagueApp
//
//  Created by Keegan Papakipos on 9/13/17.
//  Copyright © 2017 Keegan Papakipos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var summonerNameInputField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func riotAPICall(summonerName: String) {
        //TODO: Encode special characters of name
        let encodedName = summonerName
        let urlString = URL(string: "https://na1.api.riotgames.com/lol/summoner/v3/summoners/by-name/\(encodedName)?api_key=RGAPI-b597a009-b928-4e87-bf74-86cb658e6aeb")
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
    
    @IBAction func searchPressed(_ sender: AnyObject) {
        //TODO: Error checking
        riotAPICall(summonerName: summonerNameInputField.text!)
    }
    
}
