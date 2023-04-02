//
//  OnboardingConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 28/03/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class OnboardingConfigurator {
    static let shared = OnboardingConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: OnboardingViewController) {
        
        let presenter = OnboardingPresenter()
        
        let interactor = OnboardingInteractor()
        interactor.presenter = presenter
        
        let router = OnboardingRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
