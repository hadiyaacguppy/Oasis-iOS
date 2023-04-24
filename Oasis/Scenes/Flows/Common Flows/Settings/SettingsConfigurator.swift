//
//  SettingsConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 24/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class SettingsConfigurator {
    static let shared = SettingsConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: SettingsViewController) {
        
        let presenter = SettingsPresenter()
        
        let interactor = SettingsInteractor()
        interactor.presenter = presenter
        
        let router = SettingsRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
