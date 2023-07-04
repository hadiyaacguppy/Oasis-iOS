//
//  TeensGoalDetailsInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 04/07/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol TeensGoalDetailsInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol TeensGoalDetailsDataStore {
    
}

class TeensGoalDetailsInteractor: TeensGoalDetailsDataStore{
    
    var presenter: TeensGoalDetailsInteractorOutput?
    
}

extension TeensGoalDetailsInteractor: TeensGoalDetailsViewControllerOutput{
    
}
