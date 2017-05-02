//
//  CustomColor.swift
//  Winder
//
//  Created by Yugui Chen on 16/11/12.
//  Copyright © 2016年 Team Winder. All rights reserved.
//

import UIKit
// #5aaa78
// #498c96
extension UIColor{
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    func getWustlGreen() -> UIColor{
        
        return UIColor(red:0, green:115/255 ,blue:96/255 , alpha:1.00)
    }
    
    func getWustlGreenLight() -> UIColor{
        
        return UIColor(red:19, green:115/255 ,blue:96/255 , alpha:1.00)
    }
    
    func getCustomColor(_ index:Int)-> UIColor{
        switch index {
        case 0:
            return UIColor(red: 56/255, green: 146/255, blue: 85/255, alpha: 1.00)
        case 1:
            return UIColor(red: 20/255, green: 188/255, blue: 76/255, alpha: 1.00)
        case 2:
            return UIColor(red: 0/255, green: 115/255, blue: 96/255, alpha: 1.00)
        case 3:
            return UIColor(red: 33/255, green: 159/255, blue: 27/255, alpha: 1.00)
        default:
            return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.00)
        }
    }
}


