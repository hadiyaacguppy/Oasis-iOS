//
//  Data+Extensions.swift
//  Oasis
//
//  Created by Wassim on 11/9/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation

extension Data {
    
    public func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> [String:Any]? {
        return try JSONSerialization.jsonObject(with: self, options: options) as? [String: Any]
    }
    
    public func jsonArray(options: JSONSerialization.ReadingOptions = []) throws -> [[String:Any]]? {
        return try JSONSerialization.jsonObject(with: self, options: options) as? [[String: Any]]
    }
    
}
