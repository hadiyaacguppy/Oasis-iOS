//
//  QRCodeRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 04/07/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol QRCodeRouterDataPassing: AnyObject {
    var dataStore: QRCodeDataStore? { get }
}

class QRCodeRouter: QRCodeRouterDataPassing{
    
    weak var viewController: QRCodeViewController!
    var dataStore: QRCodeDataStore?
    
    init(viewController: QRCodeViewController,
         dataStore: QRCodeDataStore){
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
