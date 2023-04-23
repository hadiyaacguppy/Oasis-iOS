//
//  ChildrenRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol ChildrenRouterDataPassing: AnyObject {
    var dataStore: ChildrenDataStore? { get }
}

class ChildrenRouter: ChildrenRouterDataPassing{
    
    weak var viewController: ChildrenViewController!
    var dataStore: ChildrenDataStore?
    
    init(viewController: ChildrenViewController,
         dataStore: ChildrenDataStore){
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
