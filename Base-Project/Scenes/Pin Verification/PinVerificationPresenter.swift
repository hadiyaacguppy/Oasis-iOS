//
//  PinVerificationPresenter.swift
//  Healr
//
//  Created by Mhmd Rizk on 11/28/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//  
import Foundation

protocol PinVerificationPresenterOutput: class {
    

}

class PinVerificationPresenter {
    
    weak var output: PinVerificationPresenterOutput?
    
    // MARK: Presentation logic
    
}
extension PinVerificationPresenter: PinVerificationInteractorOutput {
    
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
