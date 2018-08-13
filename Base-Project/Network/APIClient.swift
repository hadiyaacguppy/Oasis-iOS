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
    
    init(){
        provider = MoyaProvider<BaseProjectService>()
        
        
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
                    let clientError = error.errorResponse
                    observer.onError(clientError)
                })
            return Disposables.create {
                print(#function + "Disposed")
            }
        })
    }
    */
    
}

