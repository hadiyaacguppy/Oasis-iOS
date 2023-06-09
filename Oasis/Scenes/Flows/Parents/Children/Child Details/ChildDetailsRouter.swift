//
//  ChildDetailsRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 08/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol ChildDetailsRouterDataPassing: AnyObject {
    var dataStore: ChildDetailsDataStore? { get }
}

class ChildDetailsRouter: ChildDetailsRouterDataPassing{
    
    weak var viewController: ChildDetailsViewController!
    var dataStore: ChildDetailsDataStore?
    
    init(viewController: ChildDetailsViewController,
         dataStore: ChildDetailsDataStore){
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
