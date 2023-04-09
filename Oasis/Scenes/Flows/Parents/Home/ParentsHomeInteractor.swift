//
//  ParentsHomeInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 09/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol ParentsHomeInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol ParentsHomeDataStore {
    
}

class ParentsHomeInteractor: ParentsHomeDataStore{
    
    var presenter: ParentsHomeInteractorOutput?
    
}

extension ParentsHomeInteractor: ParentsHomeViewControllerOutput{
    
}
