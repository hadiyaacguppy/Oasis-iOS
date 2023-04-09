//
//  SelectAgeRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 09/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol SelectAgeRouterDataPassing: AnyObject {
    var dataStore: SelectAgeDataStore? { get }
}

class SelectAgeRouter: SelectAgeRouterDataPassing{
    
    weak var viewController: SelectAgeViewController!
    var dataStore: SelectAgeDataStore?
    
    init(viewController: SelectAgeViewController,
         dataStore: SelectAgeDataStore){
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
    // MARK: Navigation
    func pushToRegistration(){
        let vc = R.storyboard.registration.registrationViewControllerVC()!
        DispatchQueue
            .main
            .async {
                self.viewController.navigationController?.pushViewController(vc, animated: true)
            }
    }
    
    func redirectToLogin(){
        let vc = R.storyboard.login.loginViewControllerNavVC()!
        let window = (UIApplication.shared.delegate as! AppDelegate).window!
        DispatchQueue.main.async {
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
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
