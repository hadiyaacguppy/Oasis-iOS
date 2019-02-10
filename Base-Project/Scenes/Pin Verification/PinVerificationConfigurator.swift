//
//  PinVerificationConfigurator.swift
//  Healr
//
//  Created by Mhmd Rizk on 11/28/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//  

import UIKit

// MARK: Connect View, Interactor, and Presenter



class PinVerificationConfigurator {
    // MARK: Object lifecycle

    static let shared = PinVerificationConfigurator()

    private init() {}

    // MARK: Configuration

    func configure(viewController: PinVerificationViewController) {

        let presenter = PinVerificationPresenter()
        presenter.output = viewController

        let interactor = PinVerificationInteractor()
        interactor.output = presenter

        let router = PinVerificationRouter(viewController: viewController, dataSource: interactor, dataDestination: interactor)

        viewController.output = interactor
        viewController.router = router
    }
}
