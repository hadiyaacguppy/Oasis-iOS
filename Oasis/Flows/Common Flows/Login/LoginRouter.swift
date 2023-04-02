//
//  LoginRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol LoginRouterDataPassing: AnyObject {
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: LoginRouterDataPassing{
    
    weak var viewController: LoginViewController!
    var dataStore: LoginDataStore?
    
    init(viewController: LoginViewController,
         dataStore: LoginDataStore){
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
    // MARK: Navigation
    func redirectToRegistration(){
        let vc = R.storyboard.registration.registrationViewControllerNavVC()!
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
