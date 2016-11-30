//
//  CustomColor.swift
//  Winder
//
//  Created by Yugui Chen on 16/11/12.
//  Copyright © 2016年 cse438. All rights reserved.
//

import UIKit

extension UIColor{
    func getWustlGreenColor() -> UIColor{
        
        return UIColor(red:0, green:115/255 ,blue:96/255 , alpha:1.00)
    }
    
    func getCustomColor(index:Int)-> UIColor{
        switch index {
        case 0:
            return UIColor(red: 0, green: 0, blue: 255/255, alpha: 1.00)
        case 1:
            return UIColor(red: 0, green: 255/255, blue: 0, alpha: 1.00)
        case 2:
            return UIColor(red: 255/255, green: 0, blue: 0, alpha: 1.00)
        case 3:
            return UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        default:
            return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.00)
        }
    }
}


