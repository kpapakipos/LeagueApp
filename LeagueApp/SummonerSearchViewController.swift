//
//  ViewController.swift
//  LeagueApp
//
//  Created by Keegan Papakipos on 9/13/17.
//  Copyright © 2017 Keegan Papakipos. All rights reserved.
//

import UIKit

class SummonerSearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var regionPickerView: UIPickerView!
    @IBOutlet weak var summonerNameInputField: UITextField!
    
    var summonerInformation: [String:Any]?
    var summonerLeagues: [[String:Any]]?
    let regionTitles = ["Russia","Korea","Brazil","Oceania","Japan","North America","Europe North","Europe West","Turkey","Latin America 1","Latin America 2"]
    let regionCodes = ["Russia":"ru","Korea":"kr","Brazil":"br1","Oceania":"oc1","Japan":"jp1","North America":"na1","Europe North":"eun1","Europe West":"euw1","Turkey":"tr1","Latin America 1":"la1","Latin America 2":"la2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.regionPickerView.delegate = self
        self.regionPickerView.dataSource = self
    }
    
    @IBAction func searchPressed(_ sender: AnyObject) {
        guard let regionCode = regionCodes[regionTitles[regionPickerView.selectedRow(inComponent: 0)]] else {
            print("could not find regionCode for selected row")
            return
        }
        guard let summonerName = summonerNameInputField.text else {
            print("invalid summoner name inputted")
            return
        }
        //TODO: Text checking for disallowed characters
        NetworkingController.getSummoner(region: regionCode, summonerName: summonerName) { (summoner: [String:Any]) in
            self.summonerInformation = summoner
            guard let summonerId = (summoner["id"] as? NSNumber)?.uint64Value else {
                print("could not find summoner ID with value NSNumber in json")
                return
            }
            NetworkingController.getSummonerLeague(region: regionCode, summonerId: summonerId) { (leagues: [[String:Any]]) in
                //print(leagues)
                self.summonerLeagues = leagues
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "displaySummonerSegue", sender: nil)
                }
            }
        }
    }
    
    //MARK: PickerView
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return regionTitles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return regionTitles.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displaySummonerSegue" {
            (segue.destination as! SummonerDisplayViewController).summonerInformation = self.summonerInformation
            (segue.destination as! SummonerDisplayViewController).summonerLeagues = self.summonerLeagues
        }
    }
}
