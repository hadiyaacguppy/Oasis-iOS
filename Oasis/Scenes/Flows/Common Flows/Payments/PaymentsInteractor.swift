//
//  PaymentsInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol PaymentsInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    func didGetPayments(models : [PaymentAPIModel]) -> [PaymentsModels.ViewModels.Payment]
    
}

protocol PaymentsDataStore {
    
}

class PaymentsInteractor: PaymentsDataStore{
    
    var presenter: PaymentsInteractorOutput?
    
}

extension PaymentsInteractor: PaymentsViewControllerOutput{
    func addPayment(title: String, currency: String, amount: Int, date: String, paymentTypeID: Int) -> Single<Void>{
        var dict : [String:Any] = [:]
        dict["title"] = title
        dict["currency"] = currency
        dict["amount"] = amount
        dict["date"] = date
        dict["payment_type_id"] = paymentTypeID
        return Single<Void>.create(subscribe: { single in
            APIClient.shared.addPayment(dict: dict)
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
    
    func getPaymentsTypes() -> RxSwift.Single<Void> {
        return Single<Void>.create(subscribe: { single in
            APIClient.shared.getPaymentsTypes()
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
    
    func getPayments() -> Single<[PaymentsModels.ViewModels.Payment]> {
        return Single<[PaymentsModels.ViewModels.Payment]>.create(subscribe: { single in
            APIClient.shared.getPayments()
                .subscribe(onSuccess: { [weak self] (payments) in
                    guard let self = self else { return single(.error(ErrorViewModel.generateGenericError()))}
                    guard self.presenter != nil else { return single(.error(ErrorViewModel.generateGenericError()))}
                    single(.success((self.presenter!.didGetPayments(models: payments))))
                    }, onError: { [weak self] (error) in
                        guard let self = self else { return single(.error(ErrorViewModel.generateGenericError()))}
                        guard self.presenter != nil else { return single(.error(ErrorViewModel.generateGenericError()))}
                        single(.error(self.presenter!.apiCallFailed(withError: error.errorResponse)))
                })
        })
    }
}
