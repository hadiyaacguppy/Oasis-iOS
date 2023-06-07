//
//  GenderConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 07/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class GenderConfigurator {
    static let shared = GenderConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: GenderViewController) {
        
        let presenter = GenderPresenter()
        
        let interactor = GenderInteractor()
        interactor.presenter = presenter
        
        let router = GenderRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
