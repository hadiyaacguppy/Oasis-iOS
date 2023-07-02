//
//  AddTeensGoalInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/07/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol AddTeensGoalInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol AddTeensGoalDataStore {
    
}

class AddTeensGoalInteractor: AddTeensGoalDataStore{
    
    var presenter: AddTeensGoalInteractorOutput?
    
}

extension AddTeensGoalInteractor: AddTeensGoalViewControllerOutput{
    func addGoal(goalName: String, currency: String, amount: Int) -> RxSwift.Single<Void> {
        var dict : [String:Any] = [:]
        dict["title"] = goalName
        dict["currency"] = currency
        dict["amount"] = amount
        dict["end_date"] = ""
        dict["file"] = ""
        return Single<Void>.create(subscribe: { single in
            APIClient.shared.addGoal(dict: dict)
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
