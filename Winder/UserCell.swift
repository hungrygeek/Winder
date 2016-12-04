//
//  UserCell.swift
//  Winder
//
//  Created by ShiShu on 12/4/16.
//  Copyright © 2016 cse438. All rights reserved.
//

import Foundation
import UIKit

class UserCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}