//
//  ChildrenInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol ChildrenInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol ChildrenDataStore {
    
}

class ChildrenInteractor: ChildrenDataStore{
    
    var presenter: ChildrenInteractorOutput?
    
}

extension ChildrenInteractor: ChildrenViewControllerOutput{
    
}
