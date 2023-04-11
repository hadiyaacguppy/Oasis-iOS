//
//  InterestsInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 11/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol InterestsInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol InterestsDataStore {
    
}

class InterestsInteractor: InterestsDataStore{
    
    var presenter: InterestsInteractorOutput?
    
}

extension InterestsInteractor: InterestsViewControllerOutput{
    
}
