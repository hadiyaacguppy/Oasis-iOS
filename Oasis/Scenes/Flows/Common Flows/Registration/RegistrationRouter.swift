//
//  RegistrationRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol RegistrationRouterDataPassing: AnyObject {
    var dataStore: RegistrationDataStore? { get }
}

class RegistrationRouter: RegistrationRouterDataPassing{
    
    weak var viewController: RegistrationViewController!
    var dataStore: RegistrationDataStore?
    
    init(viewController: RegistrationViewController,
         dataStore: RegistrationDataStore){
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
    
    func pushToOTPVerificationsScene(){
        let vc = R.storyboard.otpVerification.otpVerificationViewControllerVC()!
        DispatchQueue
            .main
            .async {
                self.viewController.navigationController?.pushViewController(vc, animated: true)
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
