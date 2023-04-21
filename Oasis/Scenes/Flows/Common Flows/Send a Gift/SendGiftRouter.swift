//
//  SendGiftRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 21/04/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol SendGiftRouterDataPassing: AnyObject {
    var dataStore: SendGiftDataStore? { get }
}

class SendGiftRouter: SendGiftRouterDataPassing{
    
    weak var viewController: SendGiftViewController!
    var dataStore: SendGiftDataStore?
    
    init(viewController: SendGiftViewController,
         dataStore: SendGiftDataStore){
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
