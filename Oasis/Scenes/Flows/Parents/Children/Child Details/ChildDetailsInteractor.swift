//
//  ChildDetailsInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 08/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol ChildDetailsInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol ChildDetailsDataStore {
    
}

class ChildDetailsInteractor: ChildDetailsDataStore{
    
    var presenter: ChildDetailsInteractorOutput?
    
}

extension ChildDetailsInteractor: ChildDetailsViewControllerOutput{
    
}
