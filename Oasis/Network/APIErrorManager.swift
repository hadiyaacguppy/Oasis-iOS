//
//  APIErrorManager.swift
//  Oasis
//
//  Created by Wassim on 7/6/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SessionRepository
import Moya

class APIErrorManager{
    
    var reachabilityManager = NetworkReachabilityManager()
    
    private
    var networkIsReachable : Bool{
        return reachabilityManager?.isReachable ?? false
    }
    var appSessionRepository = SessionRepository()
    
    fileprivate
    func checkSessionValidity(_ errorObject: APIErrorModel) {
        if !appSessionRepository.sessionIsValid(withErrorCode: errorObject.code!) {
            Relays.shared.sessionIsExpired.accept(())
        }
    }
    
    func parseError(withError errorData : Error) -> NetworkErrorResponse{
        guard networkIsReachable else {
            return NetworkErrorResponse(code: -7777)
        }
        let moyaError: MoyaError? = errorData as? MoyaError
        
        let response : Response? = moyaError?.response
        
        let statusCode : Int? = response?.statusCode
        
        let unknownError = NetworkErrorResponse(code: -10)
        
        guard response != nil else{
            return unknownError
        }
        
        let bodyData = response?.data
        
        guard bodyData != nil else{
            return unknownError
        }
        
        guard statusCode != nil else {
            return unknownError
        }
        
        guard let JSON = try? JSONSerialization.jsonObject(with: bodyData!, options: []) as? [String : Any] else {
            return NetworkErrorResponse(code: statusCode!)
        }
        
        guard let errorJSON = JSON["error"] as? [String : Any] else {
            return NetworkErrorResponse(code: statusCode!)
        }
        
        guard let errorObject  = try? APIErrorModel(from: errorJSON) else {
            return NetworkErrorResponse(code: statusCode!)
        }
        guard errorObject.message != nil  else {
            return unknownError
        }
        
        let errorResponse =  NetworkErrorResponse(errorObject.code!, message: errorObject.message!)
        checkSessionValidity(errorObject)
        return errorResponse
        
    }
}

