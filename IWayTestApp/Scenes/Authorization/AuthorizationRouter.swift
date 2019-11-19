//
//  AuthorizationRouter.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/18/19.
//  Copyright (c) 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

@objc
public protocol AuthorizationRoutingLogic {
    func routeMain()
}

public protocol AuthorizationDataPassing {
    var dataStore: AuthorizationDataStore? { get }
}

public class AuthorizationRouter: NSObject, AuthorizationRoutingLogic, AuthorizationDataPassing {
    
    public weak var viewController: AuthorizationViewController?
    public var dataStore: AuthorizationDataStore?
    
    // MARK: - Routing
    public func routeMain() {
        let main = MainViewController()
        viewController?.present(main, animated: true, completion: nil)
    }
    
    // MARK: - Passing data
}
