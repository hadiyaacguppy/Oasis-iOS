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
    
    /// returns the hour of the receiver 'NSDate'
    var hourOfDay: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    /// returns the day of the week of the receiver 'NSDate'
    var dayOfWeek: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    /// returns the year of the receiver 'NSDate' as Int anno domini
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    public var isInFuture: Bool {
        return self > Date()
    }
    
    public var isInPast: Bool {
        return self < Date()
    }
    
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
    
    func dateString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
    
    /**
     transforms a unix time to a Date or String
     
     - parameter unixtimeInterval: The epochTime value as 128312087
     - parameter returnTypeYouAreAimingFor: the type you want this function to return, "Date" or "String", default is Date
     - parameter stringFormat: The date format, default is yyyy-MM-dd
     
     - returns: Any, need to cast as String || Date
     */
    func getStringFromTimeStamp(_ unixtimeInterval: Int,_ returnTypeYouAreAimingFor: ReturnTypeFromTimestamp?,_ stringFormat: String?) -> Any {
        
        let date = Date(timeIntervalSince1970: TimeInterval(unixtimeInterval))
        if returnTypeYouAreAimingFor == .date {//Return the date as Date Type if user wanted it as date
            return date
        }else{//Return the date as String
            let dateFormatter = DateFormatter()
            //dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
            //dateFormatter.locale = NSLocale.current
            
            if stringFormat == nil {//Return the default one
                dateFormatter.dateFormat = "yyyy-MM-dd"
            }else{//Or if passed return the format the user wants
                dateFormatter.dateFormat = stringFormat
            }
            
            let strDate = dateFormatter.string(from: date)
            
            return strDate
        }
    }
    
  
}
