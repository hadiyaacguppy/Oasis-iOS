//
//  APIErrorManager.swift
//  Base-Project
//
//  Created by Wassim on 7/6/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//



import Foundation
import Alamofire
import ObjectMapper
import RxSwift
import RxMoya
import Moya

extension ErrorResponse : Error{}

class APIErrorManager{
    
    var reachabilityManager = NetworkReachabilityManager()
    
    private
    var networkIsReachable : Bool{
        return reachabilityManager?.isReachable ?? false
    }
    
    fileprivate
    func parseError(withError errorData : Error) -> ErrorResponse{
        
        
        guard networkIsReachable else {
            return ErrorResponse(genericErrorCode: -7777)
        }
        let moyaError: MoyaError? = errorData as? MoyaError
        
        let response : Response? = moyaError?.response
        
        let statusCode : Int? = response?.statusCode
        
        let unknownError = ErrorResponse(genericErrorCode: -10)
        
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
        
        guard let JSON = try? JSONSerialization.jsonObject(with: bodyData!, options: []) as! [String : Any] else {
            return ErrorResponse(genericErrorCode: statusCode!)
        }
        
        guard let errorJSON = JSON["error"] as? [String : Any] else {
            return ErrorResponse(genericErrorCode: statusCode!)
        }
        
        guard let errorObject  = Mapper<APIError>().map(JSON: errorJSON) else {
            return ErrorResponse(genericErrorCode: statusCode!)
        }
        
        guard errorObject.message == nil else {
            return ErrorResponse(errorObject.code!, message: errorObject.message!)
        }
        
        return unknownError

    }
}


public enum Code  : Equatable {
    
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case internalServerError
    case unknownError
    case noInternetConnection
    case apiError(Int)
    
    public static func == (lhs: Code, rhs: Code) -> Bool {
        switch (lhs, rhs) {
        case let (.apiError(l), .apiError(r)): return l == r
        case (.badRequest,.badRequest):
            return true
        case (.unauthorized,.unauthorized):
            return true
        case (.forbidden,.forbidden):
            return true
        case (.internalServerError,.internalServerError):
            return true
        case (.unknownError,.unknownError):
            return true
        case (.noInternetConnection,.noInternetConnection):
            return true
        default:
            return false
        }
    }
    
}
public struct ErrorResponse {
    
    var code : Code
    var message : String
    
    init( _ code : Int, message msg : String) {
        self.code = .apiError(code)
        self.message = msg
    }
    
    init(genericErrorCode  gcode : Int) {
        switch gcode {
        case 400:
            self.code = .badRequest
            self.message = Constants.Error.badRequest
        case 500:
            self.code = .internalServerError
            self.message = Constants.Error.someThingWentWrong
        case 403:
            self.code = .forbidden
            self.message = Constants.Error.someThingWentWrong
        case 404:
            self.code = .notFound
            self.message = Constants.Error.notFound
        case -7777:
            self.code = .noInternetConnection
            self.message = Constants.Error.noInternet
        default :
            self.code = .unknownError
            self.message = Constants.Error.unknown
        }
        
    }
}


extension Error {
    public var errorResponse: ErrorResponse {
        return APIErrorManager().parseError(withError: self)
    }
}

