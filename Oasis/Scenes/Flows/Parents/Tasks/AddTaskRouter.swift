//
//  AddTaskRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 08/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol AddTaskRouterDataPassing: AnyObject {
    var dataStore: AddTaskDataStore? { get }
}

class AddTaskRouter: AddTaskRouterDataPassing{
    
    weak var viewController: AddTaskViewController!
    var dataStore: AddTaskDataStore?
    
    init(viewController: AddTaskViewController,
         dataStore: AddTaskDataStore){
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
