//
//  SessionManagerConstants.swift
//  SessionManager
//
//  Created by Wassim on 6/11/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
struct SessionManagerConstants  {
    struct UserDefaultKeys {
        static let sessionIdKey = "sessionId"
        static let usernameKey  = "usernameKey"
        //Just for some faking
        static let passwordKey = "timsetamp_user"
        static let firsTime = "first_time"
        
    }
    static let sessionExpiredCode = 101
}
