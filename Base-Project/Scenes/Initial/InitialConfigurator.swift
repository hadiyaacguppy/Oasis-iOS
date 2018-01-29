//
//  InitialConfigurator.swift
//  Base-Project
//
//  Created by Wassim on 1/29/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//  

import UIKit

// MARK: Connect View, Interactor, and Presenter



class InitialConfigurator {
    // MARK: Object lifecycle

    static let shared = InitialConfigurator()

    private init() {}

    // MARK: Configuration

    func configure(viewController: InitialViewController) {

        let presenter = InitialPresenter()
        presenter.output = viewController

        let interactor = InitialInteractor()
        interactor.output = presenter

        let router = InitialRouter(viewController: viewController, dataSource: interactor, dataDestination: interactor)

        viewController.output = interactor
        viewController.router = router
    }
}
