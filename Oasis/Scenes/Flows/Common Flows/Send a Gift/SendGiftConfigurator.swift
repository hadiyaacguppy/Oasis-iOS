//
//  SendGiftConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 21/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class SendGiftConfigurator {
    static let shared = SendGiftConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: SendGiftViewController) {
        
        let presenter = SendGiftPresenter()
        
        let interactor = SendGiftInteractor()
        interactor.presenter = presenter
        
        let router = SendGiftRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
