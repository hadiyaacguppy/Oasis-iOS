//
//  TeensGoalsRouter.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright (c) 2023 Tedmob. All rights reserved.
//

import UIKit

protocol TeensGoalsRouterDataPassing: AnyObject {
    var dataStore: TeensGoalsDataStore? { get }
}

class TeensGoalsRouter: TeensGoalsRouterDataPassing{
    
    weak var viewController: TeensGoalsViewController!
    var dataStore: TeensGoalsDataStore?
    
    init(viewController: TeensGoalsViewController,
         dataStore: TeensGoalsDataStore){
        self.viewController = viewController
        self.dataStore = dataStore
    }
    
    // MARK: Navigation
    func pushToAddGoalController(){
        let vc = R.storyboard.addTeensGoal.addTeensGoalViewControllerVC()!
        DispatchQueue
            .main
            .async {
                self.viewController.hidesBottomBarWhenPushed = true
                self.viewController.navigationController?.pushViewController(vc, animated: true)
            }
    }
    
    func pushToGoalDetailsController(){
        let vc = R.storyboard.teensGoalDetails.teensGoalDetailsViewControllerVC()!
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
