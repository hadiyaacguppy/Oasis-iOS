//
//  APIClient.swift
//  Base-Project
//
//  Created by Hadi on 7/5/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import Moya
import RxSwift


class  APIClient {
    
    static let shared = APIClient()
    
    
    private let provider : MoyaProvider<BaseProjectService>!
    var errorManager : APIErrorManager<APIError>
    
    init(){
        provider = MoyaProvider<BaseProjectService>()
        self.errorManager = APIErrorManager<APIError>()
    }
    
    
    // MARK : - Others
    ///Example
    /*
     func setPush(pushId: String) -> Observable<Void>{
     return Observable.create({ observer in
     _ = self.provider.rx.request(.setPush(pushId: pushId))
     .subscribe(onSuccess: { (response) in
     observer.onNext(())
     observer.onCompleted()
     
     },onError: { (error) in
     observer.onError(self.getErrorMessageFromData(passedError: error)!)
     })
     return Disposables.create {
     print(#function + "Disposed")
     }
     })
     }
     */
}

