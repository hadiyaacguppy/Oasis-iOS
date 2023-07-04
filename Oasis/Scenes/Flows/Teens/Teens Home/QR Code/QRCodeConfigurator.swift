//
//  QRCodeConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 04/07/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class QRCodeConfigurator {
    static let shared = QRCodeConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: QRCodeViewController) {
        
        let presenter = QRCodePresenter()
        
        let interactor = QRCodeInteractor()
        interactor.presenter = presenter
        
        let router = QRCodeRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
