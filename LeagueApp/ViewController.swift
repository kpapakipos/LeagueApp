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
    
    @IBAction func searchPressed(_ sender: AnyObject) {
        //TODO: Text checking
        NetworkingController.getSummonerCall(summonerName: summonerNameInputField.text!) { (summonerId: UInt64) in
            NetworkingController.getSummonerLeague(summonerId: summonerId)
        }
    }
}
