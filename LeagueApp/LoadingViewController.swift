//
//  LoadingViewController.swift
//  LeagueApp
//
//  Created by Keegan Papakipos on 9/15/17.
//  Copyright © 2017 Keegan Papakipos. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: set up loop to check whether AppModel.trackedSummoners has a value yet. If it does, continue on either NO or YES segue
        AppModel.loadTrackedSummoners {
            if AppModel.trackedSummoners.count == 0 {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "noTrackedSummonersSegue", sender: nil)
                }
            }
            else if AppModel.trackedSummoners.count > 0 {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "yesTrackedSummonersSegue", sender: nil)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
