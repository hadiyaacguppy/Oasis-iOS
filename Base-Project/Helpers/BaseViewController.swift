//
//  BaseViewController.swift
//  Base-Project
//
//  Created by Wassim on 1/26/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import UIKit
class BaseViewController : UIViewController {
    
    override
    func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismissProgress()
    }
    
    func showLoading(){
        Utilities.ProgressHUD.showLoading(withMessage: "Loading".localized)
    }
    
    func display(errorMessage msg : String ){
        Utilities.ProgressHUD.showError(withMessage: msg)
    }
    func dismissProgress(){
        Utilities.ProgressHUD.dismissLoading()
    }
}

