//
//  Ability.swift
//  Winder
//
//  Created by Yugui Chen on 16/11/22.
//  Copyright © 2016年 cse438. All rights reserved.
//

import UIKit

class AbilityView: MatchViewController {
    
    
    let abilityCard = UIView()
    let matchCard = AbilityView()
    
    private var infoArray: Array<PersonalInfo> = {
        var array: Array<PersonalInfo> = []
        var person  = PersonalInfo()
        var tempImage = UIImageView()
        var valArray = [CGFloat(0.8),CGFloat(0.6),CGFloat(0.4),CGFloat(0.2)]
        for index in 0..<numberOfCards {
            tempImage = UIImageView(image: UIImage(named: "round_\(index + 1)")!)
            person.setMyImage(tempImage)
            person.setAbilityVal(valArray)
            array.append(person)
        }
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
}
