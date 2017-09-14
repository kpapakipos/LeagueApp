//
//  SummonerDisplayViewController.swift
//  LeagueApp
//
//  Created by Keegan Papakipos on 9/13/17.
//  Copyright © 2017 Keegan Papakipos. All rights reserved.
//

import UIKit

class SummonerDisplayViewController: UIViewController {
    
    var summonerLeagues: [[String:Any]]?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let leagues = summonerLeagues else {
            print("could not load this summoner's leagues")
            return
        }
        for league in leagues {
            guard let queuetype = league["queueType"] as? String else {
                print("could not cast queueType to String")
                return
            }
            if queuetype == "RANKED_SOLO_5x5" {
                print(league)
            }
        }
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
