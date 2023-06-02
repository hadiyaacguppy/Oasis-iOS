//
//  AssignNewTaskPresenter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 12/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

class AssignNewTaskPresenter {}

extension AssignNewTaskPresenter: AssignNewTaskInteractorOutput {
    func didGetTasks(models: [TaskTypeAPIModel]) -> [AssignNewTaskModels.ViewModels.Task]{
        return models.map{createTaskType(model: $0)}
    }
    
    func createTaskType(model : TaskTypeAPIModel) -> AssignNewTaskModels.ViewModels.Task{
        return AssignNewTaskModels.ViewModels.Task(id: model.id!, title: model.name)
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
