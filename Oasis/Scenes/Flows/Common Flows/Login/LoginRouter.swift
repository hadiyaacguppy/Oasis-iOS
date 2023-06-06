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
    func redirectToSelectAge(){
        let vc = R.storyboard.selectAge.selectAgeViewControllerNavVC()!
        let window = (UIApplication.shared.delegate as! AppDelegate).window!
        DispatchQueue.main.async {
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: {
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
    
    func redirectToTabbarController(){
        let vc = TabBarController()
        let window = (UIApplication.shared.delegate as! AppDelegate).window!
        DispatchQueue.main.async {
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: {
                window.rootViewController = vc
            })
        }
    }
    
    func pushToBirthDateVC(){
        let vc = R.storyboard.birthdate.birthdateViewControllerVC()!
        
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
