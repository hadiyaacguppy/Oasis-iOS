//
//  BaseProjectService.swift
//  Base-Project
//
//  Created by Hadi on 7/5/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import Moya

enum BaseProjectService {
    
    // MARK : Login - Register - Password Change etc..
    ///Example
    //case loginWithGoogle(googleUserID : String, email : String, firstName : String, lastName : String, imageUrl : String)
    
    
    // MARK : Payment
    
    // MARK : Profile
    
    // MARK : Push
    case setPush(pushId : String)
    
    // MARK : Others
}

// MARK: - TargetType Protocol Implementation
extension BaseProjectService: TargetType {
    
    var baseURL: URL {
        return URL(string: Constants.Network.baseURl)!
    }
    
    var path: String {
        
        switch self {
            
        case .setPush:
            return "/push"
        }
    }
    var method: Moya.Method {
        switch self {
        case .setPush:
            return .post
        }
    }
    
    var task: Task {
        switch self {
            
        case .setPush(let pushId):
            return .requestParameters(parameters: ["push_id" : pushId], encoding: URLEncoding.default)
        
            
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        switch self {
        case .setPush:
            return ["session-token" : ""]
        }
    }
    
    var validationType : ValidationType {
        return .successCodes
        
    }
}
