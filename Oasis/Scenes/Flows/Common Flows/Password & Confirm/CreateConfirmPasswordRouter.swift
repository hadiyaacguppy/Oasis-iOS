//
//  CreateConfirmPasswordRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 09/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol CreateConfirmPasswordRouterDataPassing: AnyObject {
    var dataStore: CreateConfirmPasswordDataStore? { get }
}

class CreateConfirmPasswordRouter: CreateConfirmPasswordRouterDataPassing{
    
    weak var viewController: CreateConfirmPasswordViewController!
    var dataStore: CreateConfirmPasswordDataStore?
    
    init(viewController: CreateConfirmPasswordViewController,
         dataStore: CreateConfirmPasswordDataStore){
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
    // MARK: Navigation
    func redirectToLogin(){
        let vc = R.storyboard.login.loginViewControllerNavVC()!
        let window = (UIApplication.shared.delegate as! AppDelegate).window!
        DispatchQueue.main.async {
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                window.rootViewController = vc
            })
        }
    }
    
    func redirectToHome(){
        let vc = R.storyboard.parentsHome.parentsHomeViewControllerNavVC()!
        let window = (UIApplication.shared.delegate as! AppDelegate).window!
        DispatchQueue.main.async {
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: {
                window.rootViewController = vc
            })
        }
    }
    ///Pop The view from the view hierarchy
    func popView(){
        DispatchQueue.main
            .async {
                self.viewController.navigationController?.popViewController(animated: true)
            }
    }
}
