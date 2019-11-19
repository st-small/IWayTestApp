//
//  MainRouter.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/19/19.
//  Copyright (c) 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

@objc
public protocol MainRoutingLogic { }

public protocol MainDataPassing {
    var dataStore: MainDataStore? { get }
}

public class MainRouter: NSObject, MainRoutingLogic, MainDataPassing {
    public weak var viewController: MainViewController?
    public var dataStore: MainDataStore?
    
    // MARK: - Routing
    
    // MARK: - Passing data
}
