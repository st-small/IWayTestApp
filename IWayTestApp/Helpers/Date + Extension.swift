//
//  Date + Extension.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/21/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import Foundation

public extension Date {
    
    func serverFormatDate() -> String {
        let dateFormatter = formatterWithFormat(format: DateFormats.serverFormat)
        
        return dateFormatter.string(from: self)
    }
    
    private func formatterWithFormat(format: String, isPosixLocale: Bool = false) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if isPosixLocale {
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        }
        return dateFormatter
    }
}
