//
//  ShareData.swift
//  Winder
//
//  Created by ShiShu on 12/4/16.
//  Copyright © 2016 cse438. All rights reserved.
//

import Foundation

class ShareData {
    private static var __once: () = {
            Static.instance = ShareData()
        }()
    class var sharedInstance: ShareData {
        struct Static {
            static var instance: ShareData?
            static var token: Int = 0
        }
        
        _ = ShareData.__once
        
        return Static.instance!
    }
    
    
    var partnerID : String! //Some String
    var partnerName : String!
    
}
