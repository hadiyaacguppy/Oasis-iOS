//
//  AddTeensGoalInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/07/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol AddTeensGoalInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol AddTeensGoalDataStore {
    
}

class AddTeensGoalInteractor: AddTeensGoalDataStore{
    
    var presenter: AddTeensGoalInteractorOutput?
    
}

extension AddTeensGoalInteractor: AddTeensGoalViewControllerOutput{
    
}
