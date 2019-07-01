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
    
    required public init?(map: Map){}
    override init(){}
    
    public func mapping(map: Map){
        
    }
    

    @objc required public init(coder aDecoder: NSCoder){
        token = aDecoder.decodeObject(forKey: "token") as? String
        
    }
    
   
    @objc public func encode(with aCoder: NSCoder){
        
        if token != nil{
            aCoder.encode(token, forKey: "token")
        }
    }
    
}
