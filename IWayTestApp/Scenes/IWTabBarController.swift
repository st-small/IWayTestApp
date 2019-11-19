//
//  IWTabBarController.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/19/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

public class IWTabBarController: UITabBarController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let main = MainViewController()
        let mainNavigation = UINavigationController(rootViewController: main)
        mainNavigation.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        
        let profile = ProfileViewController()
        let profileNavigation = UINavigationController(rootViewController: profile)
        profile.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 1)
        
        self.viewControllers = [
            mainNavigation, profileNavigation]
    }
}

