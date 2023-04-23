//
//  TabbarController.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 17/04/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import UIKit

final class TabBarController: CardTabBarController {
    
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
        tabBar.barTintColor = Constants.Colors.Navigation.background
        tabBar.indicatorColor = Constants.Colors.TabBar.itemBackground
    }
    
    private func setupViewController() {
        viewControllers = [homeTab, childrenTab, goalsTab, profileTab]
    }

    // MARK: - TabItems
    lazy var homeTab: UIViewController = {
        let homeTabItem = UITabBarItem(title: "", image: R.image.tabbarUnselectedHome()!, selectedImage: R.image.tabbarSelectedHome()!)
        let homeNavTab = R.storyboard.parentsHome.parentsHomeViewControllerNavVC()!
        homeNavTab.tabBarItem = homeTabItem
        return homeNavTab
    }()

    lazy var childrenTab: UIViewController = {
        let searchTabItem = UITabBarItem(title: "", image: R.image.tabbarUnSelectedChildren()!, selectedImage: R.image.tabbarSelectedChildren()!)
        let navController = R.storyboard.children.childrenViewControllerNavVC()!
        navController.tabBarItem = searchTabItem
        return navController
    }()

    lazy var goalsTab: UIViewController = {
        let randomTabItem = UITabBarItem(title: "Goals", image: nil, selectedImage: nil)
        let navController = R.storyboard.parentsHome.parentsHomeViewControllerNavVC()!
        navController.tabBarItem = randomTabItem
        return navController
    }()

    lazy var profileTab: UIViewController = {
        let commentTabItem = UITabBarItem(title: "", image: R.image.tabbarUnselectedProfile()!, selectedImage: R.image.tabbarSelectedProfile()!)
        let navController = UINavigationController()
        navController.tabBarItem = commentTabItem
        return navController
    }()
}

