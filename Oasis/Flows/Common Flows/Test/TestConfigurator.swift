//
//  TestConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 28/03/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class TestConfigurator {
    static let shared = TestConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: TestViewController) {
        
        let presenter = TestPresenter()
        
        let interactor = TestInteractor()
        interactor.presenter = presenter
        
        let router = TestRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
