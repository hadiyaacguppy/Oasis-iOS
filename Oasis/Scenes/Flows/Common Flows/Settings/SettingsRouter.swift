//
//  SettingsRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 24/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol SettingsRouterDataPassing: AnyObject {
    var dataStore: SettingsDataStore? { get }
}

class SettingsRouter: SettingsRouterDataPassing{
    
    weak var viewController: SettingsViewController!
    var dataStore: SettingsDataStore?
    
    init(viewController: SettingsViewController,
         dataStore: SettingsDataStore){
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
