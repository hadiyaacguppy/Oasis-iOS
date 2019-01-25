//
//  PINPresenter.swift
//  Base-Project
//
//  Created by Hadi on 1/22/19.
//  Copyright (c) 2019 Tedmob. All rights reserved.
//

//  
import Foundation

protocol PINPresenterOutput: class {
    
    
}

class PINPresenter {
    
    weak var output: PINPresenterOutput?
    
    // MARK: Presentation logic
    
}
extension PINPresenter: PINInteractorOutput {
    
    func apiCallFailed(withError error: ErrorResponse) -> ErrorViewModel {
        return self.parseErrorViewModel(fromErrorResponse:error)
    }
    
    func parseErrorViewModel(fromErrorResponse errorResponse : ErrorResponse) -> ErrorViewModel {
        
        switch errorResponse.code{
        case .apiError:
            return ErrorViewModel(withMessage: errorResponse.message, isNoInternetAvaibleError: false, withCode: errorResponse.code )
        case .noInternetConnection:
            return ErrorViewModel(withMessage: errorResponse.message, isNoInternetAvaibleError: true, withCode: errorResponse.code )
        default:
            return ErrorViewModel(withMessage: errorResponse.message, isNoInternetAvaibleError: false, withCode: errorResponse.code )
            
        }
    }
    
}
