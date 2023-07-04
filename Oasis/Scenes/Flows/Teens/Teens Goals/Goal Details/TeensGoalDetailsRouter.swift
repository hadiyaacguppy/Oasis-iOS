//
//  TeensGoalDetailsRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 04/07/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol TeensGoalDetailsRouterDataPassing: AnyObject {
    var dataStore: TeensGoalDetailsDataStore? { get }
}

class TeensGoalDetailsRouter: TeensGoalDetailsRouterDataPassing{
    
    weak var viewController: TeensGoalDetailsViewController!
    var dataStore: TeensGoalDetailsDataStore?
    
    init(viewController: TeensGoalDetailsViewController,
         dataStore: TeensGoalDetailsDataStore){
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
