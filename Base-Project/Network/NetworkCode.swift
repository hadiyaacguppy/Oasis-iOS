//
//  NetworkCode.swift
//  Base-Project
//
//  Created by Mojtaba Al Moussawi on 4/12/21.
//  Copyright © 2021 Tedmob. All rights reserved.
//

import Foundation

public enum NetworkCode  : Equatable {
    
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case internalServerError
    case unknownError
    case noInternetConnection
    case apiError(Int)
    
    public static func == (lhs: NetworkCode, rhs: NetworkCode) -> Bool {
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
