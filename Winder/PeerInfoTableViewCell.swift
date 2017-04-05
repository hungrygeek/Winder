//
//  PeerInfoTableViewCell.swift
//  Winder
//
//  Created by Rokee on 4/5/17.
//  Copyright © 2017 Winder. All rights reserved.
//

import UIKit

class PeerInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var collection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
