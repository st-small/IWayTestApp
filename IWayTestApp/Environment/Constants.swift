//
//  Constants.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/18/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

// MARK: - Colors constants -
public struct Colors {
    static let mainBlack = UIColor(hexString: "#2E3034")
    static let mainBlue = UIColor(hexString: "#0070C0")
    static let mainGray = UIColor(hexString: "#F4F4F4")
    static let mainGreen = UIColor(hexString: "#3DBC4A")
    static let mainLightGray = UIColor(hexString: "#C9C9C9")
    static let mainOrange = UIColor(hexString: "#F38900")
    static let mainRed = UIColor(hexString: "#F32E00")
}

// MARK: - Fonts -
public struct Fonts {
    
    public enum FontsSize: CGFloat {
        case mega = 40
        case title = 22
        case head = 20
        case header = 18
        case subhead = 16
        case helper = 15
        case caption = 14
        case subcaption = 12
    }
    
    static func regular(_ size: FontsSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue, weight: .regular)
    }
    
    static func semibold(_ size: FontsSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue, weight: .semibold)
    }
    
    static func bold(_ size: FontsSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue, weight: .bold)
    }
}

// MARK: - Keychain -
public enum KeychainKeys: String {
    case token = "token"
    case refresh = "refresh"
    case login = "login"
}

// MARK: - API constants -
public struct Server {
    struct ProductionServer {
        static let baseURL = "https://testdriver.iwayex.com/v1"
    }
}

public enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

public enum ContentType: String {
    case json = "application/json"
}

