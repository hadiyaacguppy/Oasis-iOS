//
//  addGoalInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 08/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol addGoalInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol addGoalDataStore {
    
}

class addGoalInteractor: addGoalDataStore{
    
    var presenter: addGoalInteractorOutput?
    
}

extension addGoalInteractor: addGoalViewControllerOutput{
    
}
