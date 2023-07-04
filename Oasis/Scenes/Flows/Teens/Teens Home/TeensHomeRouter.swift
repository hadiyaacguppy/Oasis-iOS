//
//  TeensHomeRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol TeensHomeRouterDataPassing: AnyObject {
    var dataStore: TeensHomeDataStore? { get }
}

class TeensHomeRouter: TeensHomeRouterDataPassing{
    
    weak var viewController: TeensHomeViewController!
    var dataStore: TeensHomeDataStore?
    
    init(viewController: TeensHomeViewController,
         dataStore: TeensHomeDataStore){
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
    // MARK: Navigation
    func presentQRCodeScreen(){
        let vc = R.storyboard.qrCode.qrCodeViewControllerNavVC()!
        DispatchQueue
            .main
            .async {
                self.viewController.present(vc, animated: true)
            }
    }
    
    ///Pop The view from the view hierarchy
    func popView(){
        DispatchQueue.main
            .async {
                self.viewController.navigationController?.popViewController(animated: true)
            }
    }
}
