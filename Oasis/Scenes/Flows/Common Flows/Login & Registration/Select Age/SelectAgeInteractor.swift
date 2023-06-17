//
//  SelectAgeInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 09/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol SelectAgeInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol SelectAgeDataStore {
    
}

class SelectAgeInteractor: SelectAgeDataStore{
    
    var presenter: SelectAgeInteractorOutput?
    
}

extension SelectAgeInteractor: SelectAgeViewControllerOutput{
    
}
