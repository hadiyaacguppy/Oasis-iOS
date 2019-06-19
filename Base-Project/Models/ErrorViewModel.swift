//
//  ErrorViewModel.swift
//  Base-Project
//
//  Created by Wassim on 10/9/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//
import Foundation


struct ErrorViewModel  : Error{
    
    var message : String
    var code : Code
    var isNoInternetAvailableError : Bool
    
    init(withMessage msg : String , isNoInternetAvaibleError internet : Bool ,withCode code : Code ) {
        self.message = msg
        self.isNoInternetAvailableError = internet
        self.code = code
    }
}
