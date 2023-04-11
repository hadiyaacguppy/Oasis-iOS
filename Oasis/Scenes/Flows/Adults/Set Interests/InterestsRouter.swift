//
//  InterestsRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 11/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol InterestsRouterDataPassing: AnyObject {
    var dataStore: InterestsDataStore? { get }
}

class InterestsRouter: InterestsRouterDataPassing{
    
    weak var viewController: InterestsViewController!
    var dataStore: InterestsDataStore?
    
    init(viewController: InterestsViewController,
         dataStore: InterestsDataStore){
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
