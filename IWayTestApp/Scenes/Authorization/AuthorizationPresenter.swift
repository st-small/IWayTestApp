//
//  AuthorizationPresenter.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/18/19.
//  Copyright (c) 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

public protocol AuthorizationPresentationLogic {
    func presentData(response: Authorization.Model.Response)
}

public class AuthorizationPresenter: AuthorizationPresentationLogic {
    
    public weak var viewController: AuthorizationDisplayLogic?
    
    // MARK: - Presenting logic
    public func presentData(response: Authorization.Model.Response) {
        switch response {
        case .emptyField(let type):
            viewController?.displayData(viewModel: .emptyField(type))
        case .fail(let error):
            viewController?.displayData(viewModel: .fail(error))
        case .success:
            viewController?.displayData(viewModel: .success)
        }
    }
}
