//
//  PinVerificationRouter.swift
//  Healr
//
//  Created by Mhmd Rizk on 11/28/18.
//  Copyright (c) 2018 Tedmob. All rights reserved.
//

//  

import UIKit

protocol PinVerificationRouterInput {
    
}

protocol PinVerificationRouterDataSource: class {
    
}

protocol PinVerificationRouterDataDestination: class {
    
}

class PinVerificationRouter: PinVerificationRouterInput {
    
    weak var viewController: PinVerificationViewController!
    weak private var dataSource: PinVerificationRouterDataSource!
    weak var dataDestination: PinVerificationRouterDataDestination!
    
    init(viewController: PinVerificationViewController, dataSource: PinVerificationRouterDataSource, dataDestination: PinVerificationRouterDataDestination) {
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
