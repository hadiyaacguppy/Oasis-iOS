//
//  UIViewController+Extensions.swift
//  Base-Project
//
//  Created by Wassim on 11/9/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Navigation

extension UIViewController {
    
    public func removePreviousControllers(animated: Bool = false) {
        navigationController?.setViewControllers([self], animated: animated)
    }
    
}

// MARK: - Misc

extension UIViewController {
    
    public var isVisible: Bool {
        return self.isViewLoaded && view.window != nil
    }
    public func addChildViewController(_ child: UIViewController, toContainerView containerView: UIView) {
        addChildViewController(child)
        containerView.addSubview(child.view)
        child.didMove(toParentViewController: self)
    }
}
