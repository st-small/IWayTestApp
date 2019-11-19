//
//  ProfileRouter.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/19/19.
//  Copyright (c) 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

@objc
public protocol ProfileRoutingLogic {
    func routeAuthorization()
}

public protocol ProfileDataPassing {
    var dataStore: ProfileDataStore? { get }
}

public class ProfileRouter: NSObject, ProfileRoutingLogic, ProfileDataPassing {
    
    public weak var viewController: ProfileViewController?
    public var dataStore: ProfileDataStore?
    
    // MARK: - Routing
    public func routeAuthorization() {
        let auth = AuthorizationViewController()
        viewController?.present(auth, animated: true, completion: nil)
    }
}
