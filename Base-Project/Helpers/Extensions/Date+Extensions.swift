//
//  Date+Extensions.swift
//  Base-Project
//
//  Created by Hadi on 10/4/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation

enum ReturnTypeFromTimestamp {
    case string
    case date
}

extension Date{
    
    func convertDateToLocalTime(_ iDate: Date) -> Date {
        let timeZone: TimeZone = TimeZone.autoupdatingCurrent
        let seconds: Int = timeZone.secondsFromGMT(for: iDate)
        return Date(timeInterval: TimeInterval(seconds), since: iDate)
    }
    
    func convertDateToGlobalTime(_ iDate: Date) -> Date {
        let timeZone: TimeZone = TimeZone.autoupdatingCurrent
        let seconds: Int = -timeZone.secondsFromGMT(for: iDate)
        return Date(timeInterval: TimeInterval(seconds), since: iDate)
    }
    
    func getCurrentDateInFormat(_ format: String) -> String {
        
        let usLocale: Locale = Locale(identifier: "en_US")
        
        let timeFormatter: DateFormatter = DateFormatter()
        timeFormatter.dateFormat = format
        
        timeFormatter.timeZone = TimeZone.autoupdatingCurrent
        timeFormatter.locale = usLocale
        
        let date: Date = Date()
        let stringFromDate: String = timeFormatter.string(from: date)
        
        return stringFromDate
    }
    
    func getTimeStampForCurrentTime() -> String {
        let timestampNumber: NSNumber = NSNumber(value: (Date().timeIntervalSince1970) * 1000 as Double)
        return timestampNumber.stringValue
    }
    
    func getTimeStampFromDate(_ iDate: Date) -> String {
        let timestamp: String = String(iDate.timeIntervalSince1970)
        return timestamp
    }
    
    /**
     transforms a unix time to a Date or String
     
     - parameter unixtimeInterval: The epochTime value as 128312087
     - parameter returnTypeYouAreAimingFor: the type you want this function to return, "Date" or "String", default is Date
     - parameter stringFormat: The date format, default is yyyy-MM-dd
     
     - returns: Any, need to cast as String || Date
     */
    func getStringFromTimeStamp(_ unixtimeInterval: Int,_ returnTypeYouAreAimingFor: ReturnTypeFromTimestamp?,_ stringFormat: String = "yyyy-MM-dd") -> Any {
        
        let date = Date(timeIntervalSince1970: TimeInterval(unixtimeInterval))
        if returnTypeYouAreAimingFor == .date {//Return the date as Date Type if user wanted it as date
            return date
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = stringFormat
            
            let strDate = dateFormatter.string(from: date)
            
            return strDate
        }
    }
}
