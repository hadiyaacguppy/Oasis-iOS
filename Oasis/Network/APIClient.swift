//
//  APIClient.swift
//  Oasis
//
//  Created by Hadi on 7/5/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import Moya
import RxMoya
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

