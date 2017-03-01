//
//  DateExtension.swift
//  Winder
//
//  Created by Rokee on 3/1/17.
//  Copyright © 2017 Winder. All rights reserved.
//

import Foundation
//import SQLite



extension Date {
//    static var declaredDatatype: String {
//        return String.declaredDatatype
//    }
//    static func fromDatatypeValue(stringValue: String) -> Date {
//        return SQLDateFormatter.date(from: stringValue)!
//    }
//    var datatypeValue: String {
//        return SQLDateFormatter.string(from: self)
//    }
    
    static var declaredDatatype: String {
        return Int.declaredDatatype
    }
    
    static func fromDatatypeValue(intValue: Int) -> Date {
        return self.init(timeIntervalSince1970: TimeInterval(intValue))
    }
    
    /**
     
     return: the timestampe since 1970 as string
     */
    var datatypeValue: String {
        return String(timeIntervalSince1970)
    }
}

//let SQLDateFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
//    formatter.locale = Locale(identifier: "en_US_POSIX")
//    formatter.timeZone = TimeZone(secondsFromGMT: 0)
//    return formatter
//}()
