//
//  URL+Extensions.swift
//  Base-Project
//
//  Created by Wassim on 9/28/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
extension URL{
    
    var isHTTPSchema : Bool{
        return scheme?.hasPrefix("http") == true
    }
    
    var isHTTPSSchema : Bool{
        return scheme?.hasPrefix("https") == true
    }
    
}
