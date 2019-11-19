//
//  ProfilePresenter.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/19/19.
//  Copyright (c) 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

public protocol ProfilePresentationLogic { }

public class ProfilePresenter: ProfilePresentationLogic {
    public weak var viewController: ProfileDisplayLogic?
    
    // MARK: - Presenting logic
}
