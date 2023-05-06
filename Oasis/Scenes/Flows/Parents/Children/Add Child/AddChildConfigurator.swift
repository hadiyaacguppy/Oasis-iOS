//
//  AddChildConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 04/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class AddChildConfigurator {
    static let shared = AddChildConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: AddChildViewController) {
        
        let presenter = AddChildPresenter()
        
        let interactor = AddChildInteractor()
        interactor.presenter = presenter
        
        let router = AddChildRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
