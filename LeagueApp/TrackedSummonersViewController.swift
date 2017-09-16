//
//  TrackedSummonersViewController.swift
//  LeagueApp
//
//  Created by Keegan Papakipos on 9/14/17.
//  Copyright © 2017 Keegan Papakipos. All rights reserved.
//

import UIKit

class TrackedSummonersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var trackedSummonersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trackedSummonersTableView.delegate = self
        trackedSummonersTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        trackedSummonersTableView.reloadData()
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        trackedSummonersTableView.deselectRow(at: indexPath, animated: false)
        self.performSegue(withIdentifier: "trackedSummonerViewHistorySegue", sender: AppModel.trackedSummoners[indexPath.row])
    }
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppModel.trackedSummoners.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = trackedSummonersTableView.dequeueReusableCell(withIdentifier: "trackedSummonerCell") as? TrackedSummonerTableViewCell else {
            return TrackedSummonerTableViewCell()
        }
        cell.name = AppModel.trackedSummoners[indexPath.row].name
        cell.populate()
        return cell
    }
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "trackedSummonerViewHistorySegue" {
            guard sender as? Summoner != nil else {
                return false
            }
            return true
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "trackedSummonerViewHistorySegue" {
            guard let summoner = sender as? Summoner else {
                return
            }
            (segue.destination as? SummonerHistoryViewController)?.summoner = summoner
        }
    }
}
