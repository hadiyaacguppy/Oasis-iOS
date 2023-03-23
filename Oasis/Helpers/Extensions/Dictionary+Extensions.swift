//
//  Dictionary+Extensions.swift
//  Oasis
//
//  Created by Wassim on 11/9/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
public extension Dictionary {
    
    var jsonString : String? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        let options = JSONSerialization.WritingOptions()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
    
    /// Same as jsonString but good for printing them in the console
    var prettyJSONString : String?{
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        let options = JSONSerialization.WritingOptions.prettyPrinted
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
   
}
