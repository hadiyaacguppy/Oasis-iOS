//
//  TeensGoalsInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol TeensGoalsInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    func didGetGoals(models : [GoalAPIModel]) -> [TeensGoalsModels.ViewModels.Goal]
}

protocol TeensGoalsDataStore {
    
}

class TeensGoalsInteractor: TeensGoalsDataStore{
    
    var presenter: TeensGoalsInteractorOutput?
    
}

extension TeensGoalsInteractor: TeensGoalsViewControllerOutput{
    func getGoals() -> Single<[TeensGoalsModels.ViewModels.Goal]> {
        return Single<[TeensGoalsModels.ViewModels.Goal]>.create(subscribe: { single in
            APIClient.shared.getGoals()
                .subscribe(onSuccess: { [weak self] (goalsRoot) in
                    guard let self = self else { return single(.error(ErrorViewModel.generateGenericError()))}
                    guard self.presenter != nil else { return single(.error(ErrorViewModel.generateGenericError()))}
                    single(.success((self.presenter!.didGetGoals(models: goalsRoot.goals ?? []))))
                    }, onError: { [weak self] (error) in
                        guard let self = self else { return single(.error(ErrorViewModel.generateGenericError()))}
                        guard self.presenter != nil else { return single(.error(ErrorViewModel.generateGenericError()))}
                        single(.error(self.presenter!.apiCallFailed(withError: error.errorResponse)))
                })
        })
    }
}
