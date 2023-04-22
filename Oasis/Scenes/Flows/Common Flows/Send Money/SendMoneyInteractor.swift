//
//  SendMoneyInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 21/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol SendMoneyInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol SendMoneyDataStore {
    
}

class SendMoneyInteractor: SendMoneyDataStore{
    
    var presenter: SendMoneyInteractorOutput?
    
}

extension SendMoneyInteractor: SendMoneyViewControllerOutput{
    
}
