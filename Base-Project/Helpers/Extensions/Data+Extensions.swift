//
//  Data+Extensions.swift
//  Base-Project
//
//  Created by Wassim on 11/9/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation


extension Data {
    public func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try JSONSerialization.jsonObject(with: self, options: options)
    }
}
