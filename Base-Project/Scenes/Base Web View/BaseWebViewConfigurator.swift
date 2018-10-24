//
//  BaseWebViewConfigurator.swift
//  Base-Project
//
//  Created by Wassim on 10/24/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//  

import UIKit

// MARK: Connect View, Interactor, and Presenter



class BaseWebViewConfigurator {
    // MARK: Object lifecycle

    static let shared = BaseWebViewConfigurator()

    private init() {}

    // MARK: Configuration

    func configure(viewController: BaseWebViewViewController) {

        let presenter = BaseWebViewPresenter()
        presenter.output = viewController

        let interactor = BaseWebViewInteractor()
        interactor.output = presenter

        let router = BaseWebViewRouter(viewController: viewController, dataSource: interactor, dataDestination: interactor)

        viewController.output = interactor
        viewController.router = router
    }
}
