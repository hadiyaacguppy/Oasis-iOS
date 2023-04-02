//
//  LoginConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class LoginConfigurator {
    static let shared = LoginConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: LoginViewController) {
        
        let presenter = LoginPresenter()
        
        let interactor = LoginInteractor()
        interactor.presenter = presenter
        
        let router = LoginRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
