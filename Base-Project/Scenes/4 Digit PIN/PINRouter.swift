//
//  PINRouter.swift
//  Base-Project
//
//  Created by Hadi on 1/22/19.
//  Copyright (c) 2019 Tedmob. All rights reserved.
//

//  

import UIKit

protocol PINRouterInput {
    
}

protocol PINRouterDataSource: class {
    
}

protocol PINRouterDataDestination: class {
    
}

class PINRouter: PINRouterInput {
    
    weak var viewController: PINViewController!
    weak private var dataSource: PINRouterDataSource!
    weak var dataDestination: PINRouterDataDestination!
    
    init(viewController: PINViewController, dataSource: PINRouterDataSource, dataDestination: PINRouterDataDestination) {
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
