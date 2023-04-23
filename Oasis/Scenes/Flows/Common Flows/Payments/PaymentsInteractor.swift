//
//  PaymentsInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol PaymentsInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol PaymentsDataStore {
    
}

class PaymentsInteractor: PaymentsDataStore{
    
    var presenter: PaymentsInteractorOutput?
    
}

extension PaymentsInteractor: PaymentsViewControllerOutput{
    
}
