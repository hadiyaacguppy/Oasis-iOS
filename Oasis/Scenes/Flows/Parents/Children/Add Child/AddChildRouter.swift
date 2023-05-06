//
//  AddChildRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 04/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol AddChildRouterDataPassing: AnyObject {
    var dataStore: AddChildDataStore? { get }
}

class AddChildRouter: AddChildRouterDataPassing{
    
    weak var viewController: AddChildViewController!
    var dataStore: AddChildDataStore?
    
    init(viewController: AddChildViewController,
         dataStore: AddChildDataStore){
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
