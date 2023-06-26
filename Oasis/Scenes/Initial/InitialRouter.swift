//
//  InitialRouter.swift
//  Oasis
//
//  Created by Wassim on 10/9/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//  

import UIKit

protocol InitialRouterInput {
    
}

protocol InitialRouterDataSource: class {
    
}

protocol InitialRouterDataDestination: class {
    
}

class InitialRouter: InitialRouterInput {
    
    weak var viewController: InitialViewController!
    weak private var dataSource: InitialRouterDataSource!
    weak var dataDestination: InitialRouterDataDestination!
    
    init(viewController: InitialViewController, dataSource: InitialRouterDataSource, dataDestination: InitialRouterDataDestination) {
        self.viewController = viewController
        self.dataSource = dataSource
        self.dataDestination = dataDestination
    }
    
    // MARK: Navigation
    func redirectToOnboardingScene(){
        let vc = R.storyboard.onboarding.onboardingViewControllerNavVC()!
        let window = (UIApplication.shared.delegate as! AppDelegate).window!
        DispatchQueue.main.async {
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromBottom, animations: {
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
    
    func redirectToTeensTabbarController(){
        let vc = TeensTabbarController()
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
    
    
    // MARK: Communication
    
    func passDataToNextScene(for segue: UIStoryboardSegue) {
        // NOTE: Teach the router which scenes it can communicate with
        
    }
}
