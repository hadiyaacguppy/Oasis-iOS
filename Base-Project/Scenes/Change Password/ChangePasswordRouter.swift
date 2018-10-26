//
//  ChangePasswordRouter.swift
//  Base-Project
//
//  Created by Mhmd Rizk on 10/19/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//  

import UIKit

protocol ChangePasswordRouterInput {
    
}

protocol ChangePasswordRouterDataSource: class {
    
}

protocol ChangePasswordRouterDataDestination: class {
    
}

class ChangePasswordRouter: ChangePasswordRouterInput {
    
    weak var viewController: ChangePasswordViewController!
    weak private var dataSource: ChangePasswordRouterDataSource!
    weak var dataDestination: ChangePasswordRouterDataDestination!
    
    init(viewController: ChangePasswordViewController, dataSource: ChangePasswordRouterDataSource, dataDestination: ChangePasswordRouterDataDestination) {
        self.viewController = viewController
        self.dataSource = dataSource
        self.dataDestination = dataDestination
    }
    
    // MARK: Navigation
    
    ///Pop The view from the view hierarchy
    func popView(){
        DispatchQueue.main
            .async {
                self.viewController.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: Communication
    
    func passDataToNextScene(for segue: UIStoryboardSegue) {
        // NOTE: Teach the router which scenes it can communicate with
        
    }
}
