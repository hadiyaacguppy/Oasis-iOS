//
//  UIPageViewController+Extensions.swift
//  Base-Project
//
//  Created by Wassim Seifeddine on 12/6/17.
//  Copyright © 2017 Tedmob. All rights reserved.
//

import Foundation
import UIKit
extension UIPageViewController {
    /// Return the currently visible view controller
    var currentVisibleController: UIViewController? {
        return self.viewControllers?.first
    }
    
    /// Return the index of the currently visible view controller
    ///
    /// - parameter viewControllers: the UIViewController array that feeds the pageView
    ///
    /// - returns: The index of the visible view controller
    func getVisibleViewControllerIndex(_ viewControllers: [UIViewController]) -> Int {
        return viewControllers.index(of: currentVisibleController!)!
    }
}
