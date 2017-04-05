//
//  GroupedCellsViewTableViewCell.swift
//  Winder
//
//  Created by Rokee on 4/4/17.
//  Copyright © 2017 Winder. All rights reserved.
//  This is for personal info's table cell which will mokcing Tantan's UI 
//

import UIKit

class GroupedCellsViewTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var footerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
