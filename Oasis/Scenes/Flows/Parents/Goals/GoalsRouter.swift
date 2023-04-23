//
//  GoalsRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol GoalsRouterDataPassing: AnyObject {
    var dataStore: GoalsDataStore? { get }
}

class GoalsRouter: GoalsRouterDataPassing{
    
    weak var viewController: GoalsViewController!
    var dataStore: GoalsDataStore?
    
    init(viewController: GoalsViewController,
         dataStore: GoalsDataStore){
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
