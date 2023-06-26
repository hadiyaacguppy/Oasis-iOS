//
//  TeensHomeInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol TeensHomeInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol TeensHomeDataStore {
    
}

class TeensHomeInteractor: TeensHomeDataStore{
    
    var presenter: TeensHomeInteractorOutput?
    
}

extension TeensHomeInteractor: TeensHomeViewControllerOutput{
    
}
