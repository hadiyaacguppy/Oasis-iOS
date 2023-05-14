//
//  AssignNewTaskRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 12/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol AssignNewTaskRouterDataPassing: AnyObject {
    var dataStore: AssignNewTaskDataStore? { get }
}

class AssignNewTaskRouter: AssignNewTaskRouterDataPassing{
    
    weak var viewController: AssignNewTaskViewController!
    var dataStore: AssignNewTaskDataStore?
    
    init(viewController: AssignNewTaskViewController,
         dataStore: AssignNewTaskDataStore){
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
