//
//  Date+Extensions.swift
//  Base-Project
//
//  Created by Hadi on 10/4/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation


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
    var toLocalTime : Date {
        let autoUpdatingTimeZone = TimeZone.autoupdatingCurrent
        let seconds = autoUpdatingTimeZone.secondsFromGMT()
        return Date(timeInterval: TimeInterval(seconds), since: self)
    }
    
    
    func getCurrentDate(inFormat format  : DateFormats) -> String {
        let usLocale: Locale = Locale(identifier: "en_US")
        
        let timeFormatter: DateFormatter = DateFormatter()
        timeFormatter.dateFormat = format
        
        timeFormatter.timeZone = TimeZone.autoupdatingCurrent
        timeFormatter.locale = usLocale
        
        let date: Date = Date()
        let stringFromDate: String = timeFormatter.string(from: date)
        
        return stringFromDate
    }
    
    
    var relativeTimeString : String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        let year = 12 * month
        
        let quotient: Int
        let unit: String
        
        if secondsAgo < minute {
            quotient = secondsAgo
            unit = "second"
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "min"
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "hour"
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = "day"
        } else if secondsAgo < month {
            quotient = secondsAgo / week
            unit = "week"
        } else if secondsAgo < year {
            quotient = secondsAgo / month
            unit = "month"
        } else {
            quotient = secondsAgo / year
            unit = "year"
            
        }
        return "\(quotient) \(unit)\(quotient == 1 ? "" : "s") ago"
    }
}
