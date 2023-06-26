//
//  UploadPictureConfigurator.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

class UploadPictureConfigurator {
    static let shared = UploadPictureConfigurator()
    
    private init() {}
    
    // MARK: Configuration
    
    func configure(viewController: UploadPictureViewController) {
        
        let presenter = UploadPicturePresenter()
        
        let interactor = UploadPictureInteractor()
        interactor.presenter = presenter
        
        let router = UploadPictureRouter(viewController: viewController, dataStore: interactor)
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
