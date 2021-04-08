//
//  Double+Extensions.swift
//  Base-Project
//
//  Created by Hadi on 6/12/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation


extension Double {
    
    /// Removes all the trailing zeros in the Number
    ///
    /// - Returns: String with all zeros removed
    func stringByRemoveTrailingZero() -> String{
        
        return String(format: "%g", self)
        
    }
    
    /// Formats the Double
    ///
    /// - Parameter f: the format that you want. %.1f based on how many digit after the comma (,) you want
    /// - Returns: String representing the double formatted
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
    
    
    /// Assuming that the double is a timestamp, this functions would return it as a string
    var dateFormatted : String? {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.short //Set date style
        return dateFormatter.string(from: date)
    }
    
    /// Assuming that the double is a timestamp, this functions would return it as a string
    ///
    /// - Parameter format: The format you want the Dateformatter to use. check DateFormats in Constants file
    /// - Returns: String representing the date 
    func dateFormatted(withFormat format : DateFormats) -> String{
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: date)
    }
    
    /// This function returns a string with a formatted number with commas. Usually use this function for prices, points etc..
    /// - Example: 65,000 OR 124,927,250 OR 5,000.23
    /// - Parameters:
    ///   - minimumFractionDigits: The minimum number of digits after the decimal separator.
    ///   - maximumFractionDigits: The maximum number of digits after the decimal separator.
    /// - Returns: string with a formatted number with commas
    func formatNumberWithCommas(minimumFractionDigits: Int = 0, maximumFractionDigits: Int = 2) -> String{
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = minimumFractionDigits
        formatter.maximumFractionDigits = maximumFractionDigits
        return formatter.string(for: self) ?? ""
    }
    
}
