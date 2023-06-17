//
//  BirthdateConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class BirthdateConfigurator {
    static let shared = BirthdateConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: BirthdateViewController) {
        
        let presenter = BirthdatePresenter()
        
        let interactor = BirthdateInteractor()
        interactor.presenter = presenter
        
        let router = BirthdateRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
