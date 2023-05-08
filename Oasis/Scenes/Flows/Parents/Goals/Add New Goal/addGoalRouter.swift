//
//  addGoalRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 08/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol addGoalRouterDataPassing: AnyObject {
    var dataStore: addGoalDataStore? { get }
}

class addGoalRouter: addGoalRouterDataPassing{
    
    weak var viewController: addGoalViewController!
    var dataStore: addGoalDataStore?
    
    init(viewController: addGoalViewController,
         dataStore: addGoalDataStore){
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
