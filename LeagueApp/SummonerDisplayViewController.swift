//
//  SummonerDisplayViewController.swift
//  LeagueApp
//
//  Created by Keegan Papakipos on 9/13/17.
//  Copyright © 2017 Keegan Papakipos. All rights reserved.
//

import UIKit

class SummonerDisplayViewController: UIViewController {
    
    @IBOutlet weak var summonerNameLabel: UILabel!
    @IBOutlet weak var tierLabel: UILabel!
    @IBOutlet weak var lpLabel: UILabel!
    
    var summonerInformation: [String:Any]?
    var summonerLeagues: [[String:Any]]?

    override func viewDidLoad() {
        super.viewDidLoad()
        fillInformation()
    }
    
    func fillInformation() {
        guard let summoner = summonerInformation else {
            print("SummonerDisplay could not load this summoner's basic information")
            return
        }
        guard let leagues = summonerLeagues else {
            print("SummonerDisplay could not load this summoner's leagues")
            return
        }
        // Get name from summoner dictionary
        if let name = summoner["name"] as? String {
            summonerNameLabel.text = name
        } else {
            print("could not retrieve name for ranked solo 5x5")
        }
        // Get ranked information from summonerLeagues array
        var foundRankedSolo5x5 = false
        for league in leagues {
            guard let queuetype = league["queueType"] as? String else {
                print("could not cast queueType to String")
                return
            }
            if queuetype == "RANKED_SOLO_5x5" {
                foundRankedSolo5x5 = true
                //print(league)
                if let tier = league["tier"] as? String, let rank = league["rank"] as? String {
                    tierLabel.text = "\(tier.capitalized) \(rank)"
                } else {
                    print("could not retrieve tier information for ranked solo 5x5")
                }
                if let lp = league["leaguePoints"] as? NSNumber {
                    lpLabel.text = lp.stringValue
                } else {
                    print("could not retrieve lp for ranked solo 5x5")
                }
            }
        }
        if !foundRankedSolo5x5 {
            tierLabel.text = "No solo queue ranking"
            lpLabel.text = "No solo queue ranking"
        }
    }
    
    @IBAction func trackThisSummonerPressed(_ sender: AnyObject) {
        guard let summonerId = (self.summonerInformation?["id"] as? NSNumber)?.uint64Value else {
            print("SummonerDisplayViewController could not retrieve summonerId from summonerInformation")
            return
        }
        AppModel.trackSummoner(summonerId: summonerId)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
