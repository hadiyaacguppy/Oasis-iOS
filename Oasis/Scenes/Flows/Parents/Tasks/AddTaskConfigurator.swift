//
//  AddTaskConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 08/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class AddTaskConfigurator {
    static let shared = AddTaskConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: AddTaskViewController) {
        
        let presenter = AddTaskPresenter()
        
        let interactor = AddTaskInteractor()
        interactor.presenter = presenter
        
        let router = AddTaskRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
