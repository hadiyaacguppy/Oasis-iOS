//
//  PaymentsConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class PaymentsConfigurator {
    static let shared = PaymentsConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: PaymentsViewController) {
        
        let presenter = PaymentsPresenter()
        
        let interactor = PaymentsInteractor()
        interactor.presenter = presenter
        
        let router = PaymentsRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
