//
//  ChangePasswordConfigurator.swift
//  Base-Project
//
//  Created by Mhmd Rizk on 10/19/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//  

import UIKit

// MARK: Connect View, Interactor, and Presenter



class ChangePasswordConfigurator {
    // MARK: Object lifecycle

    static let shared = ChangePasswordConfigurator()

    private init() {}

    // MARK: Configuration

    func configure(viewController: ChangePasswordViewController) {

        let presenter = ChangePasswordPresenter()
        presenter.output = viewController

        let interactor = ChangePasswordInteractor()
        interactor.output = presenter

        let router = ChangePasswordRouter(viewController: viewController, dataSource: interactor, dataDestination: interactor)

        viewController.output = interactor
        viewController.router = router
    }
}
