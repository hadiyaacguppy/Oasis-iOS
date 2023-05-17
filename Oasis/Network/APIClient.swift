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
    
    func addChild(dict : [String:Any]) -> Single<Void>{
        return self.provider.rx.request(.addChild(dict: dict))
            .map {_ in return Void()}
    }
    
    /*func getChildren() -> Single<[Child]>{
        return self.provider.rx.request(.getChildren)
            .mapArray(Child.self)
    }
    
    func getTasksTypes() -> Single<[TaskType]>{
        return self.provider.rx.request(.getTasksTypes)
            .mapArray(TaskType.self)
    }
     
     func getGoals() -> Single<[Goal]>{
         return self.provider.rx.request(.getGoals)
             .mapArray(Goal.self)
     }
     
     func getPaymentsTypes() -> Single<[PaymentType]>{
         return self.provider.rx.request(.getPaymentsTypes)
             .mapArray(PaymentType.self)
     }
    
    func getPayments() -> Single<[Payment]>{
        return self.provider.rx.request(.getPayments)
            .mapArray(Payment.self)
    }
    
    func getInterestsTypes() -> Single<[InterestType]>{
        return self.provider.rx.request(.getinterestsTypes)
            .mapArray(InterestType.self)
    }*/
    
    func addTask(dict : [String:Any]) -> Single<Void>{
        return self.provider.rx.request(.addTask(dict: dict))
            .map {_ in return Void()}
    }
    
    func addGoal(dict : [String:Any]) -> Single<Void>{
        return self.provider.rx.request(.addGoal(dict: dict))
            .map {_ in return Void()}
    }
    
    func addPayment(dict : [String:Any]) -> Single<Void>{
        return self.provider.rx.request(.addPayment(dict: dict))
            .map {_ in return Void()}
    }
    
    func addInterest(dict : [String:Any]) -> Single<Void>{
        return self.provider.rx.request(.addInterest(dict: dict))
            .map {_ in return Void()}
    }
}

