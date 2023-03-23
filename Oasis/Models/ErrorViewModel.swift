//
//  ErrorViewModel.swift
//  Oasis
//
//  Created by Wassim on 10/9/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//
import Foundation

struct ErrorViewModel  : Error{
    
    var message : String
    var code : NetworkCode
    var isNoInternetAvailableError : Bool
    
    init(withMessage msg : String , isNoInternetAvaibleError internet : Bool ,withCode code : NetworkCode ) {
        self.message = msg
        self.isNoInternetAvailableError = internet
        self.code = code
    }
}


extension ErrorViewModel{
    
    static func generateGenericError() -> ErrorViewModel{
        return ErrorViewModel(withMessage: Constants.Error.someThingWentWrong,
                              isNoInternetAvaibleError: false,
                              withCode: .unknownError)
    }
}
