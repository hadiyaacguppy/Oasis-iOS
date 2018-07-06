//
//  APIError.swift
//  SummerApp
//
//  Created by Wassim on 6/11/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import ObjectMapper

class APIError : Mappable{
    
    var code : Int?
    var debugger : String?
    var message : String?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map)
    {
        code <- map["code"]
        debugger <- map["debugger"]
        message <- map["message"]
        
    }
    
    
    
}

