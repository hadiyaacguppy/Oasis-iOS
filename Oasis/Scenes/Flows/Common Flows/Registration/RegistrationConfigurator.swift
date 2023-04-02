//
//  RegistrationConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class RegistrationConfigurator {
    static let shared = RegistrationConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: RegistrationViewController) {
        
        let presenter = RegistrationPresenter()
        
        let interactor = RegistrationInteractor()
        interactor.presenter = presenter
        
        let router = RegistrationRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
