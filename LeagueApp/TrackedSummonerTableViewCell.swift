//
//  TrackedSummonerTableViewCell.swift
//  LeagueApp
//
//  Created by Keegan Papakipos on 9/15/17.
//  Copyright © 2017 Keegan Papakipos. All rights reserved.
//

import UIKit

class TrackedSummonerTableViewCell: UITableViewCell {
    
    var name: String = ""

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func populate() {
        nameLabel.text = name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
