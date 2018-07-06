//
//  Double+Extensions.swift
//  Base-Project
//
//  Created by Hadi on 6/12/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation


extension Double {
    /**
     Better on the eyes from self = self - 1 or the warning from --
     */
    mutating func decrement(){
        self =  self - 1
    }
    
    func stringByRemoveTrailingZero() -> String{
        
        return String(format: "%g", self)
        
    }
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
    
    /**
     Returns the Double rounded with n digits after the decimal
     */
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    var dateFormatted : String? {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.short //Set date style
        return dateFormatter.string(from: date)
    }
    func dateFormatted(withFormat format : String) -> String{
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        
        return dateFormatter.string(from: date)
    }
    
}
