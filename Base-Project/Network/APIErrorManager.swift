//
//  APIErrorManager.swift
//  Base-Project
//
//  Created by Wassim on 7/6/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//



import Foundation
import ObjectMapper
import Moya
import RxSwift
class APIErrorManager<T: Mappable> {
    
    var error : T!
    var sessionExpiredRelay = PublishSubject<Bool>()
    
    func parseError(withError errorData : Error ) -> String{
        
        let moyaError = errorData as! MoyaError
        
        let moyaErrorData = moyaError.response?.data
        
        let errorMessage = "An Unknown Error has occured. Please try again later".localized
        
        guard moyaErrorData != nil else {
            return errorMessage
        }
        guard let JSON = try? JSONSerialization.jsonObject(with: moyaErrorData!, options: []) as! [String : Any] else {
            return errorMessage
        }
        guard let errorJSON = JSON["error"] as? [String : Any] else {
            return errorMessage
        }
        guard let errorObject  = Mapper<APIError>().map(JSON: errorJSON) else {
            return errorMessage
        }
      
        guard let erroCode = errorObject.code else {
             return errorObject.message ?? ""
        }
        if erroCode == Constants.Network.SessionTokenExpiredCode {
            sessionExpiredRelay.onNext(true)
        }
        
        return errorObject.message ?? ""
    }
    
    
    
    
     let  APIStatusCode : [String : String] = [
        ///Examples
        "101" : "Invalid Pin Code",
        "102" : "Account Already Verified",
        "103" : "Invalid Token"
    ]
    
    
    
    
    
    
    
    
    
    
    
}
