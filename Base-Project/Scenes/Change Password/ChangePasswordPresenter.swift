//
//  ChangePasswordPresenter.swift
//  Base-Project
//
//  Created by Mhmd Rizk on 10/19/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//  
import Foundation

protocol ChangePasswordPresenterOutput: class {
    

}

class ChangePasswordPresenter {
    
    weak var output: ChangePasswordPresenterOutput?
    
    // MARK: Presentation logic
    
}
extension ChangePasswordPresenter: ChangePasswordInteractorOutput {
    
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
