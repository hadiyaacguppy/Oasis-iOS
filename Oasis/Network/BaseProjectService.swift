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
    case sendOTP(dict : [String:Any])//(mobile: "yaacoub.hadi@gmail.com") use this for testing
    case verifyOTP(dict : [String:Any])
    case register(dict : [String:Any])
    case login(dict : [String:Any])//( id: "yaacoub.hadi@gmail.com", password: "melhem_yaacoub") use this for testing
    
    //Children
    case addChild(dict : [String:Any])
    case getChildren
    
    //Tasks
    case getTasksTypes
    case addTask(dict : [String:Any])
    case getChildTasks
    case getGeneralTasks
    
    //Goals
    case addGoal(dict : [String:Any])
    case getGoals
    
    //Payments
    case getPaymentsTypes
    case addPayment(dict : [String:Any])
    case getPayments
    
    //Intersts
    case getinterestsTypes
    case addInterest(dict : [String:Any])//(interest_ids: "1")
    
    //Activities
    case getActivities
    
    //balance
    case getBalance
    
    //Fund
    case fund(dict : [String:Any])//("amount": 3000000)
    
    //Link Users
    case linkUsers(dict : [String:Any])//("child_id": "zeinabch.ios@gmail.com")
    
    //Get Users
    case getUsers(dict : [String:Any])//("offset": 0)
    
    //Friends
    case getFriends
    case sendFriendRequest(dict : [String:Any])//("user_id": "string")
    case acceptFriendRequest(dict : [String:Any])//("user_id": "string","accept": true)
    case getFriendsRequests
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
        case .login:
            return "login"
        case .addChild:
            return "add_child"
        case .getChildren:
            return "children"
        case .getTasksTypes:
            return "task_types"
        case .addTask:
            return "task"
        case .getGeneralTasks:
            return "tasks"
        case .getChildTasks:
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
        case .getActivities:
            return "ctivities"
        case .getBalance:
            return "balance"
        case .fund:
            return "fund"
        case .linkUsers:
            return "link_users"
        case .getUsers:
            return "get_users"
        case .getFriends:
            return "friends"
        case .sendFriendRequest:
            return "friend_request"
        case .acceptFriendRequest:
            return "accept_request"
        case .getFriendsRequests:
            return "friend_request"
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .setOneSignalUserPush, .register, .sendOTP, .verifyOTP, .addChild, .addTask, .addGoal, .addPayment, .addInterest, .login, .fund, .getUsers, .linkUsers, .sendFriendRequest, .acceptFriendRequest:
            return .post
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
            
        case .setOneSignalUserPush(let token):
            return requestParameters(parameters: ["player_id":token])
        case .register(let dict), .sendOTP(let dict), .verifyOTP(let dict), .addChild(let dict), .addTask(let dict), .addGoal(let dict), .addPayment(let dict), .addInterest(let dict), .login(let dict), .fund(let dict), .linkUsers(let dict), .getUsers(let dict), .sendFriendRequest(let dict), .acceptFriendRequest(let dict):
            return requestParameters(parameters: dict)
        case .getChildren, .getTasksTypes, .getPaymentsTypes, .getPayments, .getGoals, .getinterestsTypes, .getActivities, .getBalance, .getFriends, .getFriendsRequests, .getChildTasks, .getGeneralTasks:
            return .requestPlain
            
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        var headersDict : [String:String] = [:]
        
        if self.sessionRepository.userIsLoggedIn {
            headersDict["Authorization"] = "Bearer " + (SessionRepository.shared.token ?? "")
        }
        
        headersDict["Content-Type"] = "application/json"
        
        return headersDict
    }
    
    var validationType : ValidationType {
        return .successCodes
    }
}

extension BaseProjectService: AccessTokenAuthorizable {
    var authorizationType: Moya.AuthorizationType? {
        switch self {
        default:
            return .bearer
        }
    }
}
extension BaseProjectService {
    func requestParameters(parameters : [String : Any]) -> Task {
        return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
    }
}
