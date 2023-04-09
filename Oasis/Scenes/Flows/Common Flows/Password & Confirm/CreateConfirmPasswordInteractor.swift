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
    
}
