//
//  OnboardingInteractor.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 28/03/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import Foundation
import RxSwift

protocol OnboardingInteractorOutput {
    
    func apiCallFailed(withError error : NetworkErrorResponse) -> ErrorViewModel
    
}

protocol OnboardingDataStore {
    
}

class OnboardingInteractor: OnboardingDataStore{
    
    var presenter: OnboardingInteractorOutput?
    
}

extension OnboardingInteractor: OnboardingViewControllerOutput{
    
}
