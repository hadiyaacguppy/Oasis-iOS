//
//  GenderInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 07/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol GenderInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol GenderDataStore {
    
}

class GenderInteractor: GenderDataStore{
    
    var presenter: GenderInteractorOutput?
    
}

extension GenderInteractor: GenderViewControllerOutput{
    
}
