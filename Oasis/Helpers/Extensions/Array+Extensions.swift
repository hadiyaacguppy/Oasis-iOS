//
//  Array+Extensions.swift
//  Oasis
//
//  Created by Hadi on 7/5/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation

extension Array {
    
    
    var toString : String {
        var arrayOfString = [String]()
        for object in self {
            arrayOfString.append("\(object)")
        }
        let str =  arrayOfString.joined(separator: ",")
        return "[" + str + "]"
        
    }
  
}
