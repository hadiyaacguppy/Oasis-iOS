//
//  UploadPictureRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol UploadPictureRouterDataPassing: AnyObject {
    var dataStore: UploadPictureDataStore? { get }
}

class UploadPictureRouter: UploadPictureRouterDataPassing{
    
    weak var viewController: UploadPictureViewController!
    var dataStore: UploadPictureDataStore?
    
    init(viewController: UploadPictureViewController,
         dataStore: UploadPictureDataStore){
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
