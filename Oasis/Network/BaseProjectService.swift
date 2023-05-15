//
//  BaseProjectService.swift
//  Oasis
//
//  Created by Hadi on 7/5/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import Moya
import SessionRepository


enum BaseProjectService {
    
    var sessionRepository : SessionRepository  {
       return SessionRepository()
    }
    case setOneSignalUserPush( token : String)
    
    //Registration
    case sendOTP(dict : [String:Any])
    case verifyOTP(dict : [String:Any])
    case register(dict : [String:Any])
}


extension BaseProjectService: TargetType {
    
    var baseURL: URL {
        return URL(string: Constants.Network.baseURl)!
    }
    
    var path: String {
        
        switch self {
            
        case .setOneSignalUserPush:
            return "push/set_user_push"
        case .register:
            return "register"
        case .sendOTP:
            return "otps/send"
        case .verifyOTP:
            return "otps/verify"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .setOneSignalUserPush, .register, .sendOTP, .verifyOTP:
            return .post
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
            
        case .setOneSignalUserPush(let token):
            return requestParameters(parameters: ["player_id":token])
        case .register(let dict), .sendOTP(let dict), .verifyOTP(let dict):
            return requestParameters(parameters: dict)
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        var headersDict : [String:String] = [:]
        
        if self.sessionRepository.userIsLoggedIn {
            headersDict["token"] = self.sessionRepository.currentUser?.token ?? ""
        }
        
        headersDict["Content-Type"] = "application/json"
        
       return headersDict
    }
    
    var validationType : ValidationType {
        return .successCodes
    }
}


extension BaseProjectService {
    func requestParameters(parameters : [String : Any]) -> Task {
        return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
    }
}
