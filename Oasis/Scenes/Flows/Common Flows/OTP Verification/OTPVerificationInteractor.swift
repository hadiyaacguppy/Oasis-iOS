//
//  OTPVerificationInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 03/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol OTPVerificationInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol OTPVerificationDataStore {
    
}

class OTPVerificationInteractor: OTPVerificationDataStore{
    
    var presenter: OTPVerificationInteractorOutput?
    
}

extension OTPVerificationInteractor: OTPVerificationViewControllerOutput{
    func sendOTP() -> Single<Void> {
        var dict : [String:Any] = [:]
        dict["mobile"] = RegistrationDataManager.current.userEmail
        return Single<Void>.create(subscribe: { single in
            APIClient.shared.sendOTP(dict: dict)
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
    
    func verifyOTP(pin: String) -> Single<Void> {
        var dict : [String:Any] = [:]
        dict["mobile"] = RegistrationDataManager.current.userEmail
        dict["otp"] = pin
        return Single<Void>.create(subscribe: { single in
            APIClient.shared.verifyOTP(dict: dict)
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
