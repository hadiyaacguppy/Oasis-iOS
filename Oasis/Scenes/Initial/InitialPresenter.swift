//
//  InitialPresenter.swift
//  Oasis
//
//  Created by Wassim on 10/9/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//  
import Foundation

protocol InitialPresenterOutput: AnyObject {
    
    
}

class InitialPresenter {
    
    weak var output: InitialPresenterOutput?
    
    // MARK: Presentation logic
    
}
extension InitialPresenter: InitialInteractorOutput {
    
    func apiCallFailed(withError error: NetworkErrorResponse) -> ErrorViewModel {
        return self.parseErrorViewModel(fromErrorResponse:error)
    }
    
    func parseErrorViewModel(fromErrorResponse errorResponse : NetworkErrorResponse) -> ErrorViewModel {
        
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
