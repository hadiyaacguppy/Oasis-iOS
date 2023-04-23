//
//  PaymentsRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol PaymentsRouterDataPassing: AnyObject {
    var dataStore: PaymentsDataStore? { get }
}

class PaymentsRouter: PaymentsRouterDataPassing{
    
    weak var viewController: PaymentsViewController!
    var dataStore: PaymentsDataStore?
    
    init(viewController: PaymentsViewController,
         dataStore: PaymentsDataStore){
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
