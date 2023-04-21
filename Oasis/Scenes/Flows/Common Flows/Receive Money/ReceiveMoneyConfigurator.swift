//
//  ReceiveMoneyConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 21/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class ReceiveMoneyConfigurator {
    static let shared = ReceiveMoneyConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: ReceiveMoneyViewController) {
        
        let presenter = ReceiveMoneyPresenter()
        
        let interactor = ReceiveMoneyInteractor()
        interactor.presenter = presenter
        
        let router = ReceiveMoneyRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
