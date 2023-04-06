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
    
}
