//
//  SelectAgeConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 09/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class SelectAgeConfigurator {
    static let shared = SelectAgeConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: SelectAgeViewController) {
        
        let presenter = SelectAgePresenter()
        
        let interactor = SelectAgeInteractor()
        interactor.presenter = presenter
        
        let router = SelectAgeRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
