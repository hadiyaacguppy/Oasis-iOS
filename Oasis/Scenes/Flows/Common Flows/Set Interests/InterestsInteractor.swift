//
//  InterestsInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 11/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol InterestsInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    func didGetInterestsTypes(models : [InterestTypeAPIModel]) -> [InterestsModels.ViewModels.Interest]
}

protocol InterestsDataStore {
    
}

class InterestsInteractor: InterestsDataStore{
    
    var presenter: InterestsInteractorOutput?
    
}

extension InterestsInteractor: InterestsViewControllerOutput{
    func getInterestsTypes() -> RxSwift.Single<[InterestsModels.ViewModels.Interest]> {
        return Single<[InterestsModels.ViewModels.Interest]>.create(subscribe: { single in
            APIClient.shared.getInterestsTypes()
                .subscribe(onSuccess: { [weak self] (interests) in
                    guard let self = self else { return single(.error(ErrorViewModel.generateGenericError()))}
                    guard self.presenter != nil else { return single(.error(ErrorViewModel.generateGenericError()))}
                    single(.success((self.presenter!.didGetInterestsTypes(models: interests))))
                    }, onError: { [weak self] (error) in
                        guard let self = self else { return single(.error(ErrorViewModel.generateGenericError()))}
                        guard self.presenter != nil else { return single(.error(ErrorViewModel.generateGenericError()))}
                        single(.error(self.presenter!.apiCallFailed(withError: error.errorResponse)))
                })
        })
    }
    
    
}
