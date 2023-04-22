//
//  SendMoneyConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 21/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class SendMoneyConfigurator {
    static let shared = SendMoneyConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: SendMoneyViewController) {
        
        let presenter = SendMoneyPresenter()
        
        let interactor = SendMoneyInteractor()
        interactor.presenter = presenter
        
        let router = SendMoneyRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
