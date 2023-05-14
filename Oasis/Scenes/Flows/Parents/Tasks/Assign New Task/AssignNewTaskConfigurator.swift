//
//  AssignNewTaskConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 12/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class AssignNewTaskConfigurator {
    static let shared = AssignNewTaskConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: AssignNewTaskViewController) {
        
        let presenter = AssignNewTaskPresenter()
        
        let interactor = AssignNewTaskInteractor()
        interactor.presenter = presenter
        
        let router = AssignNewTaskRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
