//
//  AddTeensGoalConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/07/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class AddTeensGoalConfigurator {
    static let shared = AddTeensGoalConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: AddTeensGoalViewController) {
        
        let presenter = AddTeensGoalPresenter()
        
        let interactor = AddTeensGoalInteractor()
        interactor.presenter = presenter
        
        let router = AddTeensGoalRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
