//
//  GoalsInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol GoalsInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol GoalsDataStore {
    
}

class GoalsInteractor: GoalsDataStore{
    
    var presenter: GoalsInteractorOutput?
    
}

extension GoalsInteractor: GoalsViewControllerOutput{
    
}
