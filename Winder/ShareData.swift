//
//  ShareData.swift
//  Winder
//
//  Created by ShiShu on 12/4/16.
//  Copyright © 2016 cse438. All rights reserved.
//

import Foundation

class ShareData {
    class var sharedInstance: ShareData {
        struct Static {
            static var instance: ShareData?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ShareData()
        }
        
        return Static.instance!
    }
    
    
    var partnerID : String! //Some String
    var partnerName : String!
    
}