//
//  Reactive+Dictionary.swift
//  Base-Project
//
//  Created by Wassim on 9/13/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

enum JSONMappingError : Swift.Error {
    
    case mappingError([String : Any])
    case arrayMappingError(Any)
    
    public var errorDescription: String? {
        switch self {
        case let .mappingError(json):
            return "Failed to map \(json) to Requested Type"
        case let .arrayMappingError(json):
            return "Failed to map \(json) to Requested Type"
        }
    }
}

