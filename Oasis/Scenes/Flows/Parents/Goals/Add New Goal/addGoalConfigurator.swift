//
//  addGoalConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 08/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class addGoalConfigurator {
    static let shared = addGoalConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: addGoalViewController) {
        
        let presenter = addGoalPresenter()
        
        let interactor = addGoalInteractor()
        interactor.presenter = presenter
        
        let router = addGoalRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
