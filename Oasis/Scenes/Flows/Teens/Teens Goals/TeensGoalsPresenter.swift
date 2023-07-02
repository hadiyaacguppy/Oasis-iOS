//
//  TeensGoalsPresenter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

class TeensGoalsPresenter {}

extension TeensGoalsPresenter: TeensGoalsInteractorOutput {
    func didGetGoals(models: [GoalAPIModel]) -> [TeensGoalsModels.ViewModels.Goal] {
        return models.map{createGoal(model: $0)}
    }
    
    func createGoal(model : GoalAPIModel) -> TeensGoalsModels.ViewModels.Goal {
        return TeensGoalsModels.ViewModels.Goal(goalID: model.id!,
                                                goalTitle: model.title,
                                                amount: model.amount,
                                                saved: model.saved,
                                                currency: model.currency)
        
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
