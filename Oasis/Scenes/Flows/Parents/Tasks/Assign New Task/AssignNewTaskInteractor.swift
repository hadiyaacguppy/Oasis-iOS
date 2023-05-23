//
//  AssignNewTaskInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 12/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol AssignNewTaskInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol AssignNewTaskDataStore {
    
}

class AssignNewTaskInteractor: AssignNewTaskDataStore{
    
    var presenter: AssignNewTaskInteractorOutput?
    
}

extension AssignNewTaskInteractor: AssignNewTaskViewControllerOutput{
    func getTaskTypes() -> RxSwift.Single<Void> {
        return Single<Void>.create(subscribe: { single in
            APIClient.shared.getTasksTypes()
                .subscribe(onSuccess: { [weak self] _ in
                    guard let self = self else { return single(.error(ErrorViewModel.generateGenericError()))}
                    guard self.presenter != nil else { return single(.error(ErrorViewModel.generateGenericError()))}
                    single(.success(()))
                    }, onError: { [weak self] (error) in
                        guard let self = self else { return single(.error(ErrorViewModel.generateGenericError()))}
                        guard self.presenter != nil else { return single(.error(ErrorViewModel.generateGenericError()))}
                        single(.error(self.presenter!.apiCallFailed(withError: error.errorResponse)))
                })
        })
    }
    
    func addTask(title: String, currency: String, amount: Int, childID: String, taskTypeID: Int) -> RxSwift.Single<Void> {
        var dict : [String:Any] = [:]
        dict["title"] = title
        dict["currency"] = currency
        dict["amount"] = amount
        dict["child_id"] = childID
        dict["task_type_id"] = taskTypeID
        return Single<Void>.create(subscribe: { single in
            APIClient.shared.addTask(dict: dict)
                .subscribe(onSuccess: { [weak self] _ in
                    guard let self = self else { return single(.error(ErrorViewModel.generateGenericError()))}
                    guard self.presenter != nil else { return single(.error(ErrorViewModel.generateGenericError()))}
                    single(.success(()))
                    }, onError: { [weak self] (error) in
                        guard let self = self else { return single(.error(ErrorViewModel.generateGenericError()))}
                        guard self.presenter != nil else { return single(.error(ErrorViewModel.generateGenericError()))}
                        single(.error(self.presenter!.apiCallFailed(withError: error.errorResponse)))
                })
        })
    }
    
    
}
