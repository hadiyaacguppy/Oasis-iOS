//
//  TeensProfileInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol TeensProfileInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol TeensProfileDataStore {
    
}

class TeensProfileInteractor: TeensProfileDataStore{
    
    var presenter: TeensProfileInteractorOutput?
    
}

extension TeensProfileInteractor: TeensProfileViewControllerOutput{
    
}
