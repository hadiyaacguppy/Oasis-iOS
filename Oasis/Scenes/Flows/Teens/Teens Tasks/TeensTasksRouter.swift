//
//  TeensTasksRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol TeensTasksRouterDataPassing: AnyObject {
    var dataStore: TeensTasksDataStore? { get }
}

class TeensTasksRouter: TeensTasksRouterDataPassing{
    
    weak var viewController: TeensTasksViewController!
    var dataStore: TeensTasksDataStore?
    
    init(viewController: TeensTasksViewController,
         dataStore: TeensTasksDataStore){
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
