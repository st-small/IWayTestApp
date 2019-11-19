//
//  APIConfiguration.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/18/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import Alamofire
import Foundation

public protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Data? { get }
    
    func asURLRequest() throws -> URLRequest
}
