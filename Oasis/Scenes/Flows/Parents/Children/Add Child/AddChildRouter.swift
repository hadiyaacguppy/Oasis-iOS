//
//  AddChildRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 04/05/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol AddChildRouterDataPassing: AnyObject {
    var dataStore: AddChildDataStore? { get }
}

class AddChildRouter: AddChildRouterDataPassing{
    
    weak var viewController: AddChildViewController!
    var dataStore: AddChildDataStore?
    
    init(viewController: AddChildViewController,
         dataStore: AddChildDataStore){
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
    // MARK: Navigation
    
    func pushToAddTaskController(){
        let vc = R.storyboard.addTask.addTaskViewControllerVC()!
        DispatchQueue
            .main
            .async {
                self.viewController.hidesBottomBarWhenPushed = true
                self.viewController.navigationController?.pushViewController(vc, animated: true)
            }
    }
    
    func pushToAssignNewTaskController(){
        let vc = R.storyboard.assignNewTask.assignNewTaskViewControllerVC()!
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
