//
//  GenderRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 07/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol GenderRouterDataPassing: AnyObject {
    var dataStore: GenderDataStore? { get }
}

class GenderRouter: GenderRouterDataPassing{
    
    weak var viewController: GenderViewController!
    var dataStore: GenderDataStore?
    
    init(viewController: GenderViewController,
         dataStore: GenderDataStore){
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
    ///Pop The view from the view hierarchy
    func popView(){
        DispatchQueue.main
            .async {
                self.viewController.navigationController?.popViewController(animated: true)
            }
    }
}
