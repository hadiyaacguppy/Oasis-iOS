//
//  ParentsHomeRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 09/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol ParentsHomeRouterDataPassing: AnyObject {
    var dataStore: ParentsHomeDataStore? { get }
}

class ParentsHomeRouter: ParentsHomeRouterDataPassing{
    
    weak var viewController: ParentsHomeViewController!
    var dataStore: ParentsHomeDataStore?
    
    init(viewController: ParentsHomeViewController,
         dataStore: ParentsHomeDataStore){
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
