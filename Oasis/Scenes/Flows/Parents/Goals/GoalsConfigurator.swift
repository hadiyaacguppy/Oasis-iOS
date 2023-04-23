//
//  GoalsConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class GoalsConfigurator {
    static let shared = GoalsConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: GoalsViewController) {
        
        let presenter = GoalsPresenter()
        
        let interactor = GoalsInteractor()
        interactor.presenter = presenter
        
        let router = GoalsRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
