//
//  Array+Extensions.swift
//  Base-Project
//
//  Created by Hadi on 7/5/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation

extension Array {
    
    ///Function that takes an array of Any, and returns a String of combined items to send in API
    static func prepareArrayToSend(arrayToSend array : [Any]) -> String?{
        var arrayOfString = [String]()
        for object in array {
            arrayOfString.append("\(object)")
        }
        let str =  arrayOfString.joined(separator: ",")
        return "[" + str + "]"
    }
    
    static func reverseArray(_ array: [AnyObject]) -> [AnyObject] {
        return array.reversed()
    }
}
