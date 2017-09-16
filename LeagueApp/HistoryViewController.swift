//
//  HistoryViewController.swift
//  LeagueApp
//
//  Created by Keegan Papakipos on 9/15/17.
//  Copyright © 2017 Keegan Papakipos. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    var summoner: Summoner?

    @IBOutlet weak var summonerNameLabel: UILabel!
    @IBOutlet weak var historyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let sum = summoner else {
            print("HistoryViewController could not load summoner at viewDidLoad")
            return
        }
        summonerNameLabel.text = sum.name
        historyTextView.text = sum.history.description
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
    }
}
