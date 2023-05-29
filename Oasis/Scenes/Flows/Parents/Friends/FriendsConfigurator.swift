//
//  FriendsConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 29/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class FriendsConfigurator {
    static let shared = FriendsConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: FriendsViewController) {
        
        let presenter = FriendsPresenter()
        
        let interactor = FriendsInteractor()
        interactor.presenter = presenter
        
        let router = FriendsRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
