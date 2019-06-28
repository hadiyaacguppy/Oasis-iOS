//
//  BaseProjectService.swift
//  Base-Project
//
//  Created by Hadi on 7/5/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import Moya
import SessionManager


enum BaseProjectService {
    
    var sessionManager : SessionManager  {
       return SessionManager()
    }
    case setOneSignalUserPush( token : String)

    
}


extension BaseProjectService: TargetType {
    
    var baseURL: URL {
        return URL(string: Constants.Network.baseURl)!
    }
    
    var path: String {
        
        switch self {
            
        case .setOneSignalUserPush:
            return "push/set_user_push"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .setOneSignalUserPush:
            return .post
        }
    }
    
    var task: Task {
        switch self {
            
        case .setOneSignalUserPush(let token):
            return .requestParameters(parameters: ["player_id":token], encoding: URLEncoding.default)
        
            
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
       return ["session-token" : self.sessionManager.currentUser.token ?? "" ]
    }
    
    var validationType : ValidationType {
        return .successCodes
        
    }
}
