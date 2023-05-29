//
//  GoalsInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol GoalsInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    func didGetGoals(models : [GoalAPIModel]) -> [GoalsModels.ViewModels.Goal]
}

protocol GoalsDataStore {
    
}

class GoalsInteractor: GoalsDataStore{
    
    var presenter: GoalsInteractorOutput?
    
}

extension GoalsInteractor: GoalsViewControllerOutput{
    func getGoals() -> Single<[GoalsModels.ViewModels.Goal]> {
        return Single<[GoalsModels.ViewModels.Goal]>.create(subscribe: { single in
            APIClient.shared.getGoals()
                .subscribe(onSuccess: { [weak self] (goals) in
                    guard let self = self else { return single(.error(ErrorViewModel.generateGenericError()))}
                    guard self.presenter != nil else { return single(.error(ErrorViewModel.generateGenericError()))}
                    single(.success((self.presenter!.didGetGoals(models: goals))))
                    }, onError: { [weak self] (error) in
                        guard let self = self else { return single(.error(ErrorViewModel.generateGenericError()))}
                        guard self.presenter != nil else { return single(.error(ErrorViewModel.generateGenericError()))}
                        single(.error(self.presenter!.apiCallFailed(withError: error.errorResponse)))
                })
        })
    }
    
    
}
