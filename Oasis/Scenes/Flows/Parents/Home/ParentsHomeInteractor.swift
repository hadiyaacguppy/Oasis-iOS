//
//  ParentsHomeInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 09/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol ParentsHomeInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol ParentsHomeDataStore {
    
}

class ParentsHomeInteractor: ParentsHomeDataStore{
    
    var presenter: ParentsHomeInteractorOutput?
    
}

extension ParentsHomeInteractor: ParentsHomeViewControllerOutput{
    func getPayments() -> Single<Void> {
        return Single<Void>.create(subscribe: { single in
            APIClient.shared.getPayments()
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
