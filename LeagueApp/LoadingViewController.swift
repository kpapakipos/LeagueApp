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
