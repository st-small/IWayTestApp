//
//  MainPresenter.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/19/19.
//  Copyright (c) 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

public protocol MainPresentationLogic {
    func presentData(_ response: Main.Model.Response)
}

public class MainPresenter: MainPresentationLogic {
    
    public weak var viewController: MainDisplayLogic?
    
    // MARK: - Presenting logic
    public func presentData(_ response: Main.Model.Response) {
        switch response {
        case .pointShared(let model):
            viewController?.displayData(.pointShared(model))
        case .fail(let error):
            viewController?.displayData(.fail(error))
        }
    }
    
}
