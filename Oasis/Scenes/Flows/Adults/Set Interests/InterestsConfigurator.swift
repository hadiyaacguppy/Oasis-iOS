//
//  InterestsConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 11/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class InterestsConfigurator {
    static let shared = InterestsConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: InterestsViewController) {
        
        let presenter = InterestsPresenter()
        
        let interactor = InterestsInteractor()
        interactor.presenter = presenter
        
        let router = InterestsRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
