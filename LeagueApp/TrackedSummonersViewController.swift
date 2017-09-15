//
//  TrackedSummonersViewController.swift
//  LeagueApp
//
//  Created by Keegan Papakipos on 9/14/17.
//  Copyright © 2017 Keegan Papakipos. All rights reserved.
//

import UIKit

class TrackedSummonersViewController: UIViewController {

    @IBOutlet weak var trackedSummonersTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        populateTextViewWithSummoners()
    }
    
    func populateTextViewWithSummoners() {
        trackedSummonersTextView.text = ""
        for (i, summoner) in AppModel.trackedSummoners.enumerated() {
            trackedSummonersTextView.text.append("\(i+1). ")
            trackedSummonersTextView.text.append(summoner.name)
            trackedSummonersTextView.text.append("\r")
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.trackedSummonersTextView.setContentOffset(.zero, animated: false)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
