//
//  ActivityIndicator.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/18/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import Foundation
import SVProgressHUD

public protocol ActivityIndicator {
    func show(_ status: String?)
    func dismiss()
}

public class ActivityIndicatorImpl: ActivityIndicator {
    
    public func show(_ status: String?) {
        let message = status ?? ""
        SVProgressHUD.setFont(Fonts.bold(.caption))
        SVProgressHUD.setForegroundColor(Colors.mainBlack)
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: message)
    }
    
    public func dismiss() {
        SVProgressHUD.dismiss()
    }
}
