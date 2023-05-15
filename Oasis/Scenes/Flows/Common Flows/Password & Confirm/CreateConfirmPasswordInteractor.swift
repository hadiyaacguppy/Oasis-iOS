//
//  CreateConfirmPasswordInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 09/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol CreateConfirmPasswordInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol CreateConfirmPasswordDataStore {
    
}

class CreateConfirmPasswordInteractor: CreateConfirmPasswordDataStore{
    
    var presenter: CreateConfirmPasswordInteractorOutput?
    
}

extension CreateConfirmPasswordInteractor: CreateConfirmPasswordViewControllerOutput{
    func register(password: String) -> Single<Void>{
        var dict : [String:Any] = [:]
        dict["id"] = RegistrationDataManager.current.userEmail!
        dict["first_name"] = RegistrationDataManager.current.userFirstName!
        dict["last_name"] = RegistrationDataManager.current.userLastName!
        dict["password"] = password
        dict["age"] = RegistrationDataManager.current.userAge!
        
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

}
