//
//  InterestsPresenter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 11/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

class InterestsPresenter {}

extension InterestsPresenter: InterestsInteractorOutput {
    
    func didGetInterestsTypes(models : [InterestTypeAPIModel]) -> [InterestsModels.ViewModels.Interest]{
        return models.map{createInterestType(model: $0)}
    }
    
    func createInterestType(model : InterestTypeAPIModel) -> InterestsModels.ViewModels.Interest{
        return InterestsModels.ViewModels.Interest(id: model.id!, name: model.name, image: model.image?.asURL())
    }

    func apiCallFailed(withError error: NetworkErrorResponse)
    -> ErrorViewModel {
        return self.parseErrorViewModel(fromErrorResponse:error)
    }
    
    func parseErrorViewModel(fromErrorResponse errorResponse : NetworkErrorResponse)
    -> ErrorViewModel {
        
        switch errorResponse.code{
        case .apiError:
            return ErrorViewModel(withMessage: errorResponse.message,
                                  isNoInternetAvaibleError: false,
                                  withCode: errorResponse.code )
        case .noInternetConnection:
            return ErrorViewModel(withMessage: errorResponse.message,
                                  isNoInternetAvaibleError: true,
                                  withCode: errorResponse.code )
        default:
            return ErrorViewModel(withMessage: errorResponse.message,
                                  isNoInternetAvaibleError: false,
                                  withCode: errorResponse.code )
        }
    }
    
}
