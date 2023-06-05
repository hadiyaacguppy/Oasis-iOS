//
//  BirthdateInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol BirthdateInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol BirthdateDataStore {
    
}

class BirthdateInteractor: BirthdateDataStore{
    
    var presenter: BirthdateInteractorOutput?
    
}

extension BirthdateInteractor: BirthdateViewControllerOutput{
    
}
