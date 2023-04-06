//
//  OTPVerificationRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 03/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol OTPVerificationRouterDataPassing: AnyObject {
    var dataStore: OTPVerificationDataStore? { get }
}

class OTPVerificationRouter: OTPVerificationRouterDataPassing{
    
    weak var viewController: OTPVerificationViewController!
    var dataStore: OTPVerificationDataStore?
    
    init(viewController: OTPVerificationViewController,
         dataStore: OTPVerificationDataStore){
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
    // MARK: Navigation
    
    ///Pop The view from the view hierarchy
    func popView(){
        DispatchQueue.main
            .async {
                self.viewController.navigationController?.popViewController(animated: true)
            }
    }
}
