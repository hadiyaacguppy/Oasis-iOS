//
//  BirthdateRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol BirthdateRouterDataPassing: AnyObject {
    var dataStore: BirthdateDataStore? { get }
}

class BirthdateRouter: BirthdateRouterDataPassing{
    
    weak var viewController: BirthdateViewController!
    var dataStore: BirthdateDataStore?
    
    init(viewController: BirthdateViewController,
         dataStore: BirthdateDataStore){
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
