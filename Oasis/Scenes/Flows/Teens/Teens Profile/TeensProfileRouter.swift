//
//  TeensProfileRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol TeensProfileRouterDataPassing: AnyObject {
    var dataStore: TeensProfileDataStore? { get }
}

class TeensProfileRouter: TeensProfileRouterDataPassing{
    
    weak var viewController: TeensProfileViewController!
    var dataStore: TeensProfileDataStore?
    
    init(viewController: TeensProfileViewController,
         dataStore: TeensProfileDataStore){
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
