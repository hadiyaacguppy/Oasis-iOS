//
//  InitialRouter.swift
//  Oasis
//
//  Created by Wassim on 10/9/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//  

import UIKit

protocol InitialRouterInput {
    
}

protocol InitialRouterDataSource: class {
    
}

protocol InitialRouterDataDestination: class {
    
}

class InitialRouter: InitialRouterInput {
    
    weak var viewController: InitialViewController!
    weak private var dataSource: InitialRouterDataSource!
    weak var dataDestination: InitialRouterDataDestination!
    
    init(viewController: InitialViewController, dataSource: InitialRouterDataSource, dataDestination: InitialRouterDataDestination) {
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
