//
//  InitialViewController.swift
//  Base-Project
//
//  Created by Wassim on 1/29/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

import UIKit

protocol InitialViewControllerInput {

}

protocol InitialViewControllerOutput {
    func viewDidFinishedLoading()
}

class InitialViewController: BaseViewController, InitialViewControllerInput {

    var output: InitialViewControllerOutput?
    var router: InitialRouter?

    // MARK: Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        InitialConfigurator.shared.configure(viewController: self)
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidFinishedLoading()
        
    }

    // MARK: Requests


    // MARK: Display logic

}
extension InitialViewController: InitialPresenterOutput {
    func navigatetoLogin() {
        
    }
    
    func navigatetoMain() {
        
    }
    

}
