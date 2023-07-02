//
//  AddTeensGoalRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 02/07/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol AddTeensGoalRouterDataPassing: AnyObject {
    var dataStore: AddTeensGoalDataStore? { get }
}

class AddTeensGoalRouter: AddTeensGoalRouterDataPassing{
    
    weak var viewController: AddTeensGoalViewController!
    var dataStore: AddTeensGoalDataStore?
    
    init(viewController: AddTeensGoalViewController,
         dataStore: AddTeensGoalDataStore){
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
