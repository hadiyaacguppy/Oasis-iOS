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
    func didGetBalance(model : BalanceAPIModel) -> ParentsHomeModels.ViewModels.Balance
    func didGetPayments(models : [PaymentAPIModel]) -> [ParentsHomeModels.ViewModels.Payment]
}

protocol ParentsHomeDataStore {
    
}

class ParentsHomeInteractor: ParentsHomeDataStore{
    
    var presenter: ParentsHomeInteractorOutput?
    
}

extension ParentsHomeInteractor: ParentsHomeViewControllerOutput{
    
    func getPayments() -> Single<[ParentsHomeModels.ViewModels.Payment]> {
        return Single<[ParentsHomeModels.ViewModels.Payment]>.create(subscribe: { single in
            APIClient.shared.getPayments()
                .subscribe(onSuccess: { [weak self] (paymentsRoot) in
                    guard let self = self else { return single(.error(ErrorViewModel.generateGenericError()))}
                    guard self.presenter != nil else { return single(.error(ErrorViewModel.generateGenericError()))}
                    single(.success((self.presenter!.didGetPayments(models: paymentsRoot.payments ?? []))))
                    }, onError: { [weak self] (error) in
                        guard let self = self else { return single(.error(ErrorViewModel.generateGenericError()))}
                        guard self.presenter != nil else { return single(.error(ErrorViewModel.generateGenericError()))}
                        single(.error(self.presenter!.apiCallFailed(withError: error.errorResponse)))
                })
        })
    }
    
    func getBalance() -> Single<ParentsHomeModels.ViewModels.Balance>{
        return Single<ParentsHomeModels.ViewModels.Balance>.create(subscribe: { single in
            APIClient.shared.getBalance()
                .subscribe(onSuccess: { [weak self] (balance) in
                    guard let self = self else { return single(.error(ErrorViewModel.generateGenericError()))}
                    guard self.presenter != nil else { return single(.error(ErrorViewModel.generateGenericError()))}
                    single(.success((self.presenter!.didGetBalance(model: balance))))
                    }, onError: { [weak self] (error) in
                        guard let self = self else { return single(.error(ErrorViewModel.generateGenericError()))}
                        guard self.presenter != nil else { return single(.error(ErrorViewModel.generateGenericError()))}
                        single(.error(self.presenter!.apiCallFailed(withError: error.errorResponse)))
                })
        })
    }

    
}
