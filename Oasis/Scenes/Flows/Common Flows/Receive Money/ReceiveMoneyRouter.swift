//
//  ReceiveMoneyRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 21/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol ReceiveMoneyRouterDataPassing: AnyObject {
    var dataStore: ReceiveMoneyDataStore? { get }
}

class ReceiveMoneyRouter: ReceiveMoneyRouterDataPassing{
    
    weak var viewController: ReceiveMoneyViewController!
    var dataStore: ReceiveMoneyDataStore?
    
    init(viewController: ReceiveMoneyViewController,
         dataStore: ReceiveMoneyDataStore){
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
