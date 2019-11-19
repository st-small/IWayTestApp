//
//  APIAuthorizationRouter.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/18/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import Alamofire
import Foundation

public enum APIAuthorizationRouter: APIConfiguration {
    
    case driverAuth(_ parameters: AuthRequest)
    
    // MARK: - HTTPMethod
    public var method: HTTPMethod {
        switch self {
        case .driverAuth:
            return .post
        }
    }
    
    // MARK: - Path
    public var path: String {
        switch self {
        case .driverAuth:
            return "/driver/auth/auth"
        }
    }
    
    // MARK: - Parameters
    public var parameters: Data? {
        switch self {
        case .driverAuth(let parameters):
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let encoded = try? encoder.encode(parameters)
            return encoded
        }
    }
    
    // MARK: - URLRequestConvertible
    public func asURLRequest() throws -> URLRequest {
        let url = try Server.ProductionServer.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            urlRequest.httpBody = parameters
        }
        
        return urlRequest
    }
}
