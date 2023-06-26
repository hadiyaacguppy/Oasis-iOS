//
//  TeensHomeConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class TeensHomeConfigurator {
    static let shared = TeensHomeConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: TeensHomeViewController) {
        
        let presenter = TeensHomePresenter()
        
        let interactor = TeensHomeInteractor()
        interactor.presenter = presenter
        
        let router = TeensHomeRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
