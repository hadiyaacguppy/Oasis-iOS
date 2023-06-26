//
//  TeensProfileConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class TeensProfileConfigurator {
    static let shared = TeensProfileConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: TeensProfileViewController) {
        
        let presenter = TeensProfilePresenter()
        
        let interactor = TeensProfileInteractor()
        interactor.presenter = presenter
        
        let router = TeensProfileRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
