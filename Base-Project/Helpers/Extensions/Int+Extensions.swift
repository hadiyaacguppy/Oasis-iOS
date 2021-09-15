//
//  Int+Extensions.swift
//  Base-Project
//
//  Created by Wassim on 7/6/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation

extension Optional where Wrapped == Int {
    /// Returns the Int as bool.
    var  toBool : Bool{
        guard let self = self else {
            return false
        }
        return self == 1 ? true : false
    }
    
    var fromEpoch: Date?{
        guard let self = `self` else { return nil}
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
    
    /// This function returns a string with a formatted number with commas. Usually use this function for prices, points etc..
    /// - Example: 65,000 OR 124,927,250 OR 5,000.00
    /// - Parameters:
    ///   - minimumFractionDigits: The minimum number of digits after the decimal separator.
    /// - Returns: string with a formatted number with commas
    func formatNumberWithCommas(minimumFractionDigits: Int = 0) -> String{
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = minimumFractionDigits
        return formatter.string(for: self) ?? ""
    }
    
}

struct TimeParts: CustomStringConvertible {
    var seconds = 0
    var minutes = 0
    /// The string representation of the time parts (ex: 07:37)
    var description: String {
        return NSString(format: "%02d:%02d", minutes, seconds) as String
    }
    var done : Bool {
        return seconds == 0 && minutes ==  0
    }
}



extension Int {
    /// The time parts for this integer represented from total seconds in time.
    /// -- returns: A TimeParts struct that describes the parts of time
    func toTimeParts() -> TimeParts {
        let seconds = self
        var mins = 0
        var secs = seconds
        if seconds >= 60 {
            mins = Int(seconds / 60)
            secs = seconds - (mins * 60)
        }
        
        return TimeParts(seconds: secs, minutes: mins)
    }
    
    /// The string representation of the time parts (ex: 07:37)
    func asTimeString() -> String {
        return toTimeParts().description
    }
}
