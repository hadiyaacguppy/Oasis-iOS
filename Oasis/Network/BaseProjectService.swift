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
    
    //Children
    case addChild(dict : [String:Any])
    case getChildren
    
    //Tasks
    case getTasksTypes
    case addTask(dict : [String:Any]) //["title": "Feed the Pet","currency": "LBP","amount": 200000,"child_id": "email@hotmail.com","task_type_id": 1]
    
    //Goals
    case addGoal(dict : [String:Any]) //["title": "Travel","currency": "LBP","amount": 5000000,"end_date": "2023-05-17T13:22:33.233Z","file": ""]
    case getGoals
    
    //Payments
    case getPaymentsTypes
    case addPayment(dict : [String:Any])//["title": "Recharge Mobile","currency": "$","amount": 3,"date": "2023-05-17T13:43:14.549Z","payment_type_id": 2]
    case getPayments
    
    //Intersts
    case getinterestsTypes
    case addInterest(dict : [String:Any])//["interest_ids": "1"]
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
        case .addChild:
            return "add_child"
        case .getChildren:
            return "children"
        case .getTasksTypes:
            return "task_types"
        case .addTask:
            return "task"
        case .addGoal:
            return "goal"
        case .getGoals:
            return "goal"
        case .getPaymentsTypes:
            return "payment_types"
        case .addPayment:
            return "payment"
        case .getPayments:
            return "payment"
        case .getinterestsTypes:
            return "interest_types"
        case .addInterest:
            return "interests"
        
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .setOneSignalUserPush, .register, .sendOTP, .verifyOTP, .addChild, .addTask, .addGoal, .addPayment, .addInterest:
            return .post
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
            
        case .setOneSignalUserPush(let token):
            return requestParameters(parameters: ["player_id":token])
        case .register(let dict), .sendOTP(let dict), .verifyOTP(let dict), .addChild(let dict), .addTask(let dict), .addGoal(let dict), .addPayment(let dict), .addInterest(let dict):
            return requestParameters(parameters: dict)
        case .getChildren, .getTasksTypes, .getPaymentsTypes, .getPayments, .getGoals, .getinterestsTypes:
            return requestParameters(parameters: [:])
            
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
