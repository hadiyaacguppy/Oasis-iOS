//
//  OnboardingRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 28/03/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol OnboardingRouterDataPassing: AnyObject {
    var dataStore: OnboardingDataStore? { get }
}

class OnboardingRouter: OnboardingRouterDataPassing{
    
    weak var viewController: OnboardingViewController!
    var dataStore: OnboardingDataStore?
    
    init(viewController: OnboardingViewController,
         dataStore: OnboardingDataStore){
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
    
    func redirectToRegistration(){
        let vc = R.storyboard.selectAge.selectAgeViewControllerNavVC()!
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
