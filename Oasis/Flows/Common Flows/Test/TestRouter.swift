//
//  TestRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 28/03/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol TestRouterDataPassing: AnyObject {
    var dataStore: TestDataStore? { get }
}

class TestRouter: TestRouterDataPassing{
    
    weak var viewController: TestViewController!
    var dataStore: TestDataStore?
    
    init(viewController: TestViewController,
         dataStore: TestDataStore){
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
