//
//  TeensGoalsInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol TeensGoalsInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol TeensGoalsDataStore {
    
}

class TeensGoalsInteractor: TeensGoalsDataStore{
    
    var presenter: TeensGoalsInteractorOutput?
    
}

extension TeensGoalsInteractor: TeensGoalsViewControllerOutput{
    
}
