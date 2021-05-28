//
//  NetworkErrorResponse.swift
//  Base-Project
//
//  Created by Mojtaba Al Moussawi on 4/12/21.
//  Copyright © 2021 Tedmob. All rights reserved.
//

import Foundation

struct NetworkErrorResponse {
    
    var code : NetworkCode
    var message : String
    
    init( _ code : Int, message msg : String) {
        self.code = .apiError(code)
        self.message = msg
    }
    
    init(code : Int) {
        switch code {
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

extension NetworkErrorResponse : Error{}

extension Error {
     var errorResponse: NetworkErrorResponse {
        return APIErrorManager().parseError(withError: self)
    }
}


