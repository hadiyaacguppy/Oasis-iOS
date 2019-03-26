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
       return SessionManager.shared
    }
    case setOneSignalUserPush( token : String)

    // MARK : Others
}

// MARK: - TargetType Protocol Implementation
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
       return ["session-token" : self.sessionManager.token ?? "" ]
    }
    
    var validationType : ValidationType {
        return .successCodes
        
    }
}
