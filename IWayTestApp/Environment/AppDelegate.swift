//
//  AppDelegate.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/18/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

@UIApplicationMain
public class AppDelegate: UIResponder, UIApplicationDelegate {

    public var window: UIWindow?

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let startModule = getCurrentView()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = startModule
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func getCurrentView() -> UIViewController {
        guard let _ = KeychainWrapper.standard.string(forKey: KeychainKeys.token.rawValue) else {
            return AuthorizationViewController()
        }
        
        return IWTabBarController()
    }
}

