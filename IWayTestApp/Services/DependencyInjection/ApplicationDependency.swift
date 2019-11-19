//
//  ApplicationDependency.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/18/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import DITranquillity

public class ApplicationDependency: DIFramework {
    
    public static let container: DIContainer = {
        let container = DIContainer()
        container.append(framework: ApplicationDependency.self)
        
        assert(container.validate(checkGraphCycles: true), "Invalid dependency graph")
        
        return container
    }()
    
    public static func load(container: DIContainer) {
        
        // Activity indicator service
        container.register(ActivityIndicatorImpl.init)
            .as(check: ActivityIndicator.self) {$0}
            .lifetime(.single)
        
        // APIAuthorization service
        container.register(APIAuthorizationClientImpl.init)
            .as(check: APIAuthorizationClient.self) {$0}
            .lifetime(.single)
    }
}
