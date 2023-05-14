//
//  AssignNewTaskInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 12/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol AssignNewTaskInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol AssignNewTaskDataStore {
    
}

class AssignNewTaskInteractor: AssignNewTaskDataStore{
    
    var presenter: AssignNewTaskInteractorOutput?
    
}

extension AssignNewTaskInteractor: AssignNewTaskViewControllerOutput{
    
}
