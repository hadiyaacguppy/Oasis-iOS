//
//  OTPVerificationConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 03/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class OTPVerificationConfigurator {
    static let shared = OTPVerificationConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: OTPVerificationViewController) {
        
        let presenter = OTPVerificationPresenter()
        
        let interactor = OTPVerificationInteractor()
        interactor.presenter = presenter
        
        let router = OTPVerificationRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
