//
//  AddChildInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 04/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol AddChildInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol AddChildDataStore {
    
}

class AddChildInteractor: AddChildDataStore{
    
    var presenter: AddChildInteractorOutput?
    
}

extension AddChildInteractor: AddChildViewControllerOutput{
    
}
