//
//  ChildrenConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class ChildrenConfigurator {
    static let shared = ChildrenConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: ChildrenViewController) {
        
        let presenter = ChildrenPresenter()
        
        let interactor = ChildrenInteractor()
        interactor.presenter = presenter
        
        let router = ChildrenRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
