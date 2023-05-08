//
//  AddTaskInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 08/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol AddTaskInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol AddTaskDataStore {
    
}

class AddTaskInteractor: AddTaskDataStore{
    
    var presenter: AddTaskInteractorOutput?
    
}

extension AddTaskInteractor: AddTaskViewControllerOutput{
    
}
