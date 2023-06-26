//
//  TeensGoalsRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol TeensGoalsRouterDataPassing: AnyObject {
    var dataStore: TeensGoalsDataStore? { get }
}

class TeensGoalsRouter: TeensGoalsRouterDataPassing{
    
    weak var viewController: TeensGoalsViewController!
    var dataStore: TeensGoalsDataStore?
    
    init(viewController: TeensGoalsViewController,
         dataStore: TeensGoalsDataStore){
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
