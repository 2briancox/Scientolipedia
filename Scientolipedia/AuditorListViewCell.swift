//
//  AuditorListViewCell.swift
//  Scientolipedia
//
//  Created by Brian on 4/26/15.
//  Copyright (c) 2015 Rainien.com, LLC. All rights reserved.
//

import UIKit

class AuditorListViewCell: UITableViewCell {

    @IBOutlet weak var auditorLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
