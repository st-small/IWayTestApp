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
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

public protocol AuthorizationDataPassing {
    var dataStore: AuthorizationDataStore? { get }
}

public class AuthorizationRouter: NSObject, AuthorizationRoutingLogic, AuthorizationDataPassing {
    public weak var viewController: AuthorizationViewController?
    public var dataStore: AuthorizationDataStore?
    
    // MARK: - Routing
    //func routeToSomewhere(segue: UIStoryboardSegue?) {
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: - Passing data
    //func passDataToSomewhere(source: AuthorizationDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}
