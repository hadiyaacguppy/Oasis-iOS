//
//  TeensTasksConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class TeensTasksConfigurator {
    static let shared = TeensTasksConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: TeensTasksViewController) {
        
        let presenter = TeensTasksPresenter()
        
        let interactor = TeensTasksInteractor()
        interactor.presenter = presenter
        
        let router = TeensTasksRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
