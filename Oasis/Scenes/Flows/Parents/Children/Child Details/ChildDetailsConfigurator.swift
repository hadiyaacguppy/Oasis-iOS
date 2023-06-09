//
//  ChildDetailsConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 08/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class ChildDetailsConfigurator {
    static let shared = ChildDetailsConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: ChildDetailsViewController) {
        
        let presenter = ChildDetailsPresenter()
        
        let interactor = ChildDetailsInteractor()
        interactor.presenter = presenter
        
        let router = ChildDetailsRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
