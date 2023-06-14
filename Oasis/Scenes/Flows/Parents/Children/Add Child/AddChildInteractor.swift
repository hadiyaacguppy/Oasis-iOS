//
//  AddChildInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 04/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol AddChildInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol AddChildDataStore {
    
}

class AddChildInteractor: AddChildDataStore{
    
    var presenter: AddChildInteractorOutput?
    
}

extension AddChildInteractor: AddChildViewControllerOutput{
    func addchild(email : String, firstName : String, lastName : String, childImage : String) -> Single<Void> {
        var dict : [String:Any] = [:]
        dict["id"] = email
        dict["first_name"] = firstName
        dict["last_name"] = lastName
        dict["file"] = childImage
        dict["mobile"] = "70024284"
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
