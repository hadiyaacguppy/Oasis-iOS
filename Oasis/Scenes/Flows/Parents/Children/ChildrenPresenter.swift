//
//  ChildrenPresenter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

class ChildrenPresenter {}

extension ChildrenPresenter: ChildrenInteractorOutput {
    
    func didGetchildren() -> [ChildrenModels.ViewModels.Children] {
        let child = ChildrenModels.ViewModels.Children()
        return [child]
        //return array.map{createChild(model: $0)}
    }
    
    func createChild(model : ChildAPIModel) -> ChildrenModels.ViewModels.Children{
        return ChildrenModels.ViewModels.Children(childName: model.firstName, childAge: model.lastName, childImage: model.profile, moneySpent: model.spent, totalMoneyValue: model.balance, numberOfTasks: model.tasks?.count, numberOfGoals: model.goals?.count)
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
