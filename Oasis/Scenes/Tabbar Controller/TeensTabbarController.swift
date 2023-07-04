//
//  TeensTabbarController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 23/06/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation
import UIKit

final class TeensTabbarController: CardTabBarController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupUI()
    }

    // MARK: - UI
    private func setupUI() {
        tabBar.tintColor = Constants.Colors.TabBar.title
        tabBar.backgroundColor = Constants.Colors.background
        tabBar.barTintColor = .white
        tabBar.indicatorColor = Constants.Colors.teensOrange
    }
    
    private func setupViewController() {
        viewControllers = [homeTab, tasksTab, goalsTab, profileTab]
    }

    // MARK: - TabItems
    lazy var homeTab: UIViewController = {
        let homeTabItem = UITabBarItem(title: "", image: R.image.tabbarSelectedHome()!, selectedImage: R.image.tabbarUnselectedHome()!)
        let homeNavTab = R.storyboard.teensHome.teensHomeViewControllerNavVC()!
        homeNavTab.tabBarItem = homeTabItem
        return homeNavTab
    }()

    lazy var tasksTab: UIViewController = {
        let tasksTabItem = UITabBarItem(title: "", image: R.image.tasksTabBarUnselected()!, selectedImage: R.image.tasksTabBarSelected()!)
        let navController = R.storyboard.teensTasks.teensTasksViewControllerVC()!
        navController.tabBarItem = tasksTabItem
        return navController
    }()

    lazy var goalsTab: UIViewController = {
        let goalsTabItem = UITabBarItem(title: "", image: R.image.teensTabbarUnselectedGoals()!, selectedImage: R.image.tabbarUnselectedGoals()!)
        let navController = R.storyboard.teensGoals.teensGoalsViewControllerNavVC()!
        navController.tabBarItem = goalsTabItem
        return navController
    }()

    lazy var profileTab: UIViewController = {
        let profileTabItem = UITabBarItem(title: "", image: R.image.teensTabBarUnselectedProfile()!, selectedImage: R.image.tabbarUnselectedProfile()!)
        let navController = R.storyboard.teensProfile.teensProfileViewControllerVC()!
        navController.tabBarItem = profileTabItem
        return navController
    }()
}

