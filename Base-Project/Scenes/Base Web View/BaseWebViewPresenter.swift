//
//  BaseWebViewPresenter.swift
//  Base-Project
//
//  Created by Wassim on 10/24/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//  
import Foundation

protocol BaseWebViewPresenterOutput: class {
    
    
}

class BaseWebViewPresenter {
    
    weak var output: BaseWebViewPresenterOutput?
    
    // MARK: Presentation logic
    
}
extension BaseWebViewPresenter: BaseWebViewInteractorOutput {
    
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
