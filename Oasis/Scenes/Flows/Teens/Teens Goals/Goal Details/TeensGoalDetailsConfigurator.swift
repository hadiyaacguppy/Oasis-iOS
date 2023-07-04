//
//  TeensGoalDetailsConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 04/07/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class TeensGoalDetailsConfigurator {
    static let shared = TeensGoalDetailsConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: TeensGoalDetailsViewController) {
        
        let presenter = TeensGoalDetailsPresenter()
        
        let interactor = TeensGoalDetailsInteractor()
        interactor.presenter = presenter
        
        let router = TeensGoalDetailsRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
