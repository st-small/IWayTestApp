//
//  ProfileInteractor.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/19/19.
//  Copyright (c) 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

public protocol ProfileBusinessLogic {
    func makeRequest(request: Profile.Model.Request)
}

public protocol ProfileDataStore { }

public class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
    
    var presenter: ProfilePresentationLogic?
    
    // MARK: - Main logic
    public func makeRequest(request: Profile.Model.Request) {
        switch request {
        case .logout:
            KeychainWrapper.standard.removeObject(forKey: KeychainKeys.token.rawValue)
            KeychainWrapper.standard.removeObject(forKey: KeychainKeys.refresh.rawValue)
        }
    }
}
