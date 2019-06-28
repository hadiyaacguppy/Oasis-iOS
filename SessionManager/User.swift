//
//  User.swift
//  Base-Project
//
//  Created by Wassim on 6/28/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import Foundation
import ObjectMapper


public class User : NSObject, NSCoding, Mappable{
    public var token: String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return User()
    }
    required public init?(map: Map){}
    override init(){}
    
    public func mapping(map: Map)
    {
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder)
    {
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder)
    {
        
    }
    
}
