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
    func showAlertView(_ title: String, message: String, actions: [UIAlertAction],  withCompletionHandler handler: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alertController.addAction(action)
        }
        OperationQueue.main.addOperation {
            self.present(alertController, animated: true) {
                handler?()
            }
        }
    }
    
    func showSimpleAlertView(_ title: String, message: String,  withCompletionHandler handler: (() -> Void)? ,andDismissHandler dimiss :  (() -> Void)? = nil ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default) { action in
            dimiss?()
        })
        OperationQueue.main.addOperation {
            self.present(alertController, animated: true) {
                handler?()
            }
        }
    }
    
    func showActionSheet(wthTitle title: String?, withMessage message: String?, havingOptions actions: [UIAlertAction], withCompletionHandler handler: (() -> Void)?) {
        let actionSheet = UIAlertController(title: title ?? "", message: message ?? "", preferredStyle: .actionSheet)
        for action in actions {
            actionSheet.addAction(action)
        }
        OperationQueue.main.addOperation {
            self.present(actionSheet, animated: true) {
                handler?()
            }
        }
    }
    
    func showActivityShareController(withLinkToShare link : String){
        let activityItems = [link]
        let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
}
