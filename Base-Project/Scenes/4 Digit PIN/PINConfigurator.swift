//
//  PINConfigurator.swift
//  Base-Project
//
//  Created by Hadi on 1/22/19.
//  Copyright (c) 2019 Tedmob. All rights reserved.
//

//  

import UIKit

// MARK: Connect View, Interactor, and Presenter



class PINConfigurator {
    // MARK: Object lifecycle

    static let shared = PINConfigurator()

    private init() {}

    // MARK: Configuration

    func configure(viewController: PINViewController) {

        let presenter = PINPresenter()
        presenter.output = viewController

        let interactor = PINInteractor()
        interactor.output = presenter

        let router = PINRouter(viewController: viewController, dataSource: interactor, dataDestination: interactor)

        viewController.output = interactor
        viewController.router = router
    }
}
