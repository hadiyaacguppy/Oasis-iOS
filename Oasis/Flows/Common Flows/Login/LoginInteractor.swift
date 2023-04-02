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
    
}
