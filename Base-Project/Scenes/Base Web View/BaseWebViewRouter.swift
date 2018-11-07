//
//  BaseWebViewRouter.swift
//  Base-Project
//
//  Created by Wassim on 10/24/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//  

import UIKit

protocol BaseWebViewRouterInput {
    
}

protocol BaseWebViewRouterDataSource: class {
    
}

protocol BaseWebViewRouterDataDestination: class {
    
}

class BaseWebViewRouter: BaseWebViewRouterInput {
    
    weak var viewController: BaseWebViewViewController!
    weak private var dataSource: BaseWebViewRouterDataSource!
    weak var dataDestination: BaseWebViewRouterDataDestination!
    
    init(viewController: BaseWebViewViewController, dataSource: BaseWebViewRouterDataSource, dataDestination: BaseWebViewRouterDataDestination) {
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
