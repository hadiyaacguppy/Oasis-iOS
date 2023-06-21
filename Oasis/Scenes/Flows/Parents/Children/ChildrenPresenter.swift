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
    
    func didGetchildren(models : [ChildAPIModel]) -> [ChildrenModels.ViewModels.Children] {
        
        return models.map{createChild(model: $0)}
    }
    
    func createChild(model : ChildAPIModel) -> ChildrenModels.ViewModels.Children{
        return ChildrenModels.ViewModels.Children(childName: model.firstName ?? "",
                                                  childAge: model.age ?? "",
                                                  childImage: model.profile?.asURL(),
                                                  moneySpent: model.spent != nil ? "\(model.spent!)" : "",
                                                  totalMoneyValue: model.balance != nil ? "\(model.balance!)" : "",
                                                  numberOfTasks: model.tasks != nil ? "\(model.tasks!.count)" : "",
                                                  numberOfGoals: model.goals != nil ? "\(model.goals!.count)" : "")
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
