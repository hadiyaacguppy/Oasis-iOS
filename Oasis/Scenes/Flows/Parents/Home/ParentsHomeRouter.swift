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
    func pushToSendGiftController(){
        let vc = R.storyboard.sendGift.sendGiftViewControllerVC()!
        DispatchQueue
            .main
            .async {
                self.viewController.hidesBottomBarWhenPushed = true
                self.viewController.navigationController?.pushViewController(vc, animated: true)
            }
    }
    
    
    func pushToReceiveMoneyController(){
        let vc = R.storyboard.receiveMoney.receiveMoneyViewControllerVC()!
        DispatchQueue
            .main
            .async {
                self.viewController.hidesBottomBarWhenPushed = true
                self.viewController.navigationController?.pushViewController(vc, animated: true)
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
