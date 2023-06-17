//
//  CreateConfirmPasswordConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 09/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class CreateConfirmPasswordConfigurator {
    static let shared = CreateConfirmPasswordConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: CreateConfirmPasswordViewController) {
        
        let presenter = CreateConfirmPasswordPresenter()
        
        let interactor = CreateConfirmPasswordInteractor()
        interactor.presenter = presenter
        
        let router = CreateConfirmPasswordRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
