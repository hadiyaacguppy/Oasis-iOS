//
//  ReceiveMoneyInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 21/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol ReceiveMoneyInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol ReceiveMoneyDataStore {
    
}

class ReceiveMoneyInteractor: ReceiveMoneyDataStore{
    
    var presenter: ReceiveMoneyInteractorOutput?
    
}

extension ReceiveMoneyInteractor: ReceiveMoneyViewControllerOutput{
    
}
