//
//  ParentsHomeConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 09/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class ParentsHomeConfigurator {
    static let shared = ParentsHomeConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: ParentsHomeViewController) {
        
        let presenter = ParentsHomePresenter()
        
        let interactor = ParentsHomeInteractor()
        interactor.presenter = presenter
        
        let router = ParentsHomeRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
