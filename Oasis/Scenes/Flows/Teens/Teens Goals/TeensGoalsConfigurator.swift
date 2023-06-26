//
//  TeensGoalsConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class TeensGoalsConfigurator {
    static let shared = TeensGoalsConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: TeensGoalsViewController) {
        
        let presenter = TeensGoalsPresenter()
        
        let interactor = TeensGoalsInteractor()
        interactor.presenter = presenter
        
        let router = TeensGoalsRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
