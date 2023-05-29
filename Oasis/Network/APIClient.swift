//
//  APIClient.swift
//  Oasis
//
//  Created by Hadi on 7/5/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import SessionRepository

class  APIClient {
    static let shared = APIClient()
    private let provider : MoyaProvider<BaseProjectService>
    
    lazy var sessionRepository: SessionRepository =  {
        return SessionRepository()
    }()
    
    init(){
        provider = MoyaProvider<BaseProjectService>()
    }
    
    func setOneSignalToken(withToken token : String) -> Single<Void>{
        return self.provider.rx.request(.setOneSignalUserPush(token: token))
            .map {_ in return Void()}
    }
}

//MARK: - Registration
extension APIClient {
    
    func  sendOTP(dict : [String:Any])-> Single<Void>{
        return self.provider.rx.request(.sendOTP(dict: dict))
            .map {_ in return Void()}
    }
    
    func verifyOTP(dict : [String:Any])-> Single<Void>{
        return self.provider.rx.request(.verifyOTP(dict: dict))
            .map {_ in return Void()}
    }
    
    func register(dict : [String:Any]) -> Single<Void>{
        return self.provider.rx.request(.register(dict: dict))
            .map {_ in return Void()}
    }
    
    func login(dict : [String:Any]) -> Single<Void>{
        return self.provider.rx.request(.login(dict: dict))
            .map {_ in return Void()}
    }
    
    func addChild(dict : [String:Any]) -> Single<Void>{
        return self.provider.rx.request(.addChild(dict: dict))
            .map {_ in return Void()}
    }
    
    func getChildren() -> Single<[ChildAPIModel]>{
        return self.provider.rx.request(.getChildren)
            .map([ChildAPIModel].self)
    }
    
    func getActivities() -> Single<ChildAPIModel>{
        return self.provider.rx.request(.getActivities)
            .map(ChildAPIModel.self)
    }
    
    func getBalance() -> Single<String>{
        return self.provider.rx.request(.getBalance)
            .mapString(atKeyPath: "success")
    }
    
    func fund(dict : [String:Any]) -> Single<Void>{
        return self.provider.rx.request(.fund(dict: dict))
            .map {_ in return Void()}
    }
    
    func linkUsers(dict : [String:Any]) -> Single<Void>{
        return self.provider.rx.request(.linkUsers(dict: dict))
            .map {_ in return Void()}
    }
    
    func getUsers(dict : [String:Any]) -> Single<Void>{
        return self.provider.rx.request(.linkUsers(dict: dict))
            .map {_ in return Void()}
    }
    
    func getFriends() -> Single<Void>{
        return self.provider.rx.request(.getFriends)
            .map {_ in return Void()}
    }
    
    func sendFriendRequest(dict : [String:Any]) -> Single<Void>{
        return self.provider.rx.request(.sendFriendRequest(dict: dict))
            .map {_ in return Void()}
    }
    
    func acceptFriendRequest(dict : [String:Any]) -> Single<Void>{
        return self.provider.rx.request(.acceptFriendRequest(dict: dict))
            .map {_ in return Void()}
    }
    
    func getFriendsRequests() -> Single<Void>{
        return self.provider.rx.request(.getFriendsRequests)
            .map {_ in return Void()}
    }
    
    func getTasksTypes() -> Single<[TaskTypeAPIModel]>{
        return self.provider.rx.request(.getTasksTypes)
            .map([TaskTypeAPIModel].self)
    }
    
    func getGeneralTasks() -> Single<[TasksAPIModel]>{
        return self.provider.rx.request(.getGeneralTasks)
            .map([TasksAPIModel].self)
    }
    
    func getChildTasks() -> Single<[TasksAPIModel]>{
        return self.provider.rx.request(.getChildTasks)
            .map([TasksAPIModel].self)
    }
    
    func addTask(dict : [String:Any]) -> Single<Void>{
        return self.provider.rx.request(.addTask(dict: dict))
            .map {_ in return Void()}
    }
    
    func getPaymentsTypes() -> Single<[PaymentTypeAPIModel]>{
        return self.provider.rx.request(.getPaymentsTypes)
            .map([PaymentTypeAPIModel].self)
    }
    
    func getPayments() -> Single<[PaymentAPIModel]>{
        return self.provider.rx.request(.getPayments)
            .map([PaymentAPIModel].self)
    }
    
    func addPayment(dict : [String:Any]) -> Single<Void>{
        return self.provider.rx.request(.addPayment(dict: dict))
            .map {_ in return Void()}
    }
    
    func getGoals() -> Single<[GoalAPIModel]>{
        return self.provider.rx.request(.getGoals)
            .map([GoalAPIModel].self)
    }
     
    func addGoal(dict : [String:Any]) -> Single<Void>{
        return self.provider.rx.request(.addGoal(dict: dict))
            .map {_ in return Void()}
    }
    
    func getInterestsTypes() -> Single<[InterestTypeAPIModel]>{
        return self.provider.rx.request(.getinterestsTypes)
            .map([InterestTypeAPIModel].self)
    }
    
    func addInterest(dict : [String:Any]) -> Single<Void>{
        return self.provider.rx.request(.addInterest(dict: dict))
            .map {_ in return Void()}
    }
}

