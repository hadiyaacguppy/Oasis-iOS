//
//  addGoalInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 08/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol addGoalInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol addGoalDataStore {
    
}

class addGoalInteractor: addGoalDataStore{
    
    var presenter: addGoalInteractorOutput?
    
}

extension addGoalInteractor: addGoalViewControllerOutput{
    func addGoal(title: String, currency: String, amount: Int, endDate: String, file: String) -> RxSwift.Single<Void> {
        var dict : [String:Any] = [:]
        dict["id"] = title
        dict["first_name"] = currency
        dict["last_name"] = amount
        dict["file"] = endDate
        dict["last_name"] = file
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
