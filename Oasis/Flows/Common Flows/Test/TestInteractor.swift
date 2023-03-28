//
//  TestInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 28/03/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol TestInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol TestDataStore {
    
}

class TestInteractor: TestDataStore{
    
    var presenter: TestInteractorOutput?
    
}

extension TestInteractor: TestViewControllerOutput{
    
}
