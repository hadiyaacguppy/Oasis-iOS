//
//  SendMoneyRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 21/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol SendMoneyRouterDataPassing: AnyObject {
    var dataStore: SendMoneyDataStore? { get }
}

class SendMoneyRouter: SendMoneyRouterDataPassing{
    
    weak var viewController: SendMoneyViewController!
    var dataStore: SendMoneyDataStore?
    
    init(viewController: SendMoneyViewController,
         dataStore: SendMoneyDataStore){
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
