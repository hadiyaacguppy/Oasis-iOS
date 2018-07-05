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
    
    //Create a shared Instance from APIClient - Singelton
    static let shared = APIClient()
    /*Create a provider instance From MoyaProvider that is responsible for making requests
     You can have more than one provider and more than one service - For Example the situation that
     was in Somfy we have APIs from two different sources - like APIs from our side and APIs from looya
     So we could done that by creating two services - like SomfyService and LooyaService - And Two Providers*/
    private let provider : MoyaProvider<BaseProjectService>!
    
    init(){
        provider = MoyaProvider<BaseProjectService>()
    }
    
    
    // MARK : Error Parser
    func getErrorMessageFromData(passedError : Error) -> String?{
        
        let moyaError = passedError as! MoyaError
        
        let moyaErrorData = moyaError.response?.data
        
        var errorMessage = "Unknown Error"
        
        guard moyaErrorData != nil else {
            return errorMessage
        }
        
        if let grabbedJSON = try? JSONSerialization.jsonObject(with: moyaErrorData!, options: []) as! [String : Any] {
            
            print("Debugger Message: \(grabbedJSON)")
            
            let errorObject =  grabbedJSON["error"] as! [String : Any]
            
            errorMessage = errorObject["message"] as! String
            
            ///Example: You can check for a custom code
            if let debuggerCode = errorObject["code"] as? Int {
                if debuggerCode == -777 {
                    ///You can throw a notification and listen to it in AppDelegate or coordinator to let topViewController make some actions
//                    let nc = NotificationCenter.default
//                    nc.post(name: Notification.Name("TokenExpired"), object: nil)
                }else if debuggerCode == -900 {
                    return "-900"
                }
            }
        }
        
        return errorMessage
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



extension String : Error{
    
}
