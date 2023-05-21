//
//  LoginInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol LoginInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol LoginDataStore {
    
}

class LoginInteractor: LoginDataStore{
    
    var presenter: LoginInteractorOutput?
    
}

extension LoginInteractor: LoginViewControllerOutput{
    func login(id: String, password: String) -> RxSwift.Single<Void> {
        var dict : [String:Any] = [:]
        dict["id"] = id
        dict["password"] = password
        return Single<Void>.create(subscribe: { single in
            APIClient.shared.login(dict: dict)
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
