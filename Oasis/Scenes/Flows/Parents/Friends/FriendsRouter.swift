//
//  FriendsRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 29/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol FriendsRouterDataPassing: AnyObject {
    var dataStore: FriendsDataStore? { get }
}

class FriendsRouter: FriendsRouterDataPassing{
    
    weak var viewController: FriendsViewController!
    var dataStore: FriendsDataStore?
    
    init(viewController: FriendsViewController,
         dataStore: FriendsDataStore){
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
