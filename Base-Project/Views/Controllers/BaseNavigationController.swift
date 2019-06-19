//
//  BaseNavigationController.swift
//  Base-Project
//
//  Created by Mojtaba Almoussawi on 7/5/18.
//  Copyright © 2018 Tedmob. All rights reserved.

import UIKit

class BaseNavigationController: UINavigationController {
    // MARK: - Lifecycle
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.setup()
    }
    
    override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    public var style : NavigationBarType? = .normal{
        didSet{
            switch style! {
            case .custom(let appearance):
                if isNavigationBarHidden { self.setNavigationBarHidden(false, animated: false)}
                self.navigationBar.applyStyle(appearance: appearance)
            case .hidden:
                self.setNavigationBarHidden(true, animated: true)
            case .normal:
                if isNavigationBarHidden { self.setNavigationBarHidden(false, animated: false)}
                self.navigationBar.resetAppearance()
            case .transparent:
                if isNavigationBarHidden { self.setNavigationBarHidden(false, animated: false)}
                self.navigationBar.applyTransparency()
            case .appDefault:
                if isNavigationBarHidden { self.setNavigationBarHidden(false, animated: false)}
                self.navigationBar.applyStyle(appearance: NavigationBarType.NavigationBarAppearance().getAppBaseStyle())
            }
        }
    }
    
    private func setup() {
        delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This needs to be in here, not in init
        interactivePopGestureRecognizer?.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactivePopGestureRecognizer?.isEnabled = true
    }
    
    deinit {
        delegate = nil
        interactivePopGestureRecognizer?.delegate = nil
    }
    
    // MARK: - Overrides
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        duringPushAnimation = true
        
        super.pushViewController(viewController, animated: animated)
    }
    
    
    // MARK: - Private Properties
    
    fileprivate var duringPushAnimation = false
}

// MARK: - UINavigationControllerDelegate

extension BaseNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let swipeNavigationController = navigationController as? BaseNavigationController else { return }
        
        swipeNavigationController.duringPushAnimation = false
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC   : UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
}

// MARK: - UIGestureRecognizerDelegate

extension BaseNavigationController {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == interactivePopGestureRecognizer else {
            return true // default value
        }
        
        // Disable pop gesture in two situations:
        // 1) when the pop animation is in progress
        // 2) when user swipes quickly a couple of times and animations don't have time to be performed
        return viewControllers.count > 1 && duringPushAnimation == false
    }
}
