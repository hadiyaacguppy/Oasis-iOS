//
//  RegistrationInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol RegistrationInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol RegistrationDataStore {
    
}

class RegistrationInteractor: RegistrationDataStore{
    
    var presenter: RegistrationInteractorOutput?
    
}

extension RegistrationInteractor: RegistrationViewControllerOutput{
    
    
}
