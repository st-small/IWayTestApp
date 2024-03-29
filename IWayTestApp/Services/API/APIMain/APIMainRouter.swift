//
//  APIMainRouter.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/19/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import Alamofire
import Foundation

public enum APIMainRouter: APIConfiguration {
    
    case sharePosition(_ parameters: [CoordinatesRequest])
    
    // MARK: - HTTPMethod
    public var method: HTTPMethod {
        switch self {
        case .sharePosition:
            return .post
        }
    }
    
    // MARK: - Path
    public var path: String {
        switch self {
        case .sharePosition:
            return "/locations/create"
        }
    }
    
    // MARK: - Parameters
    public var parameters: Data? {
        switch self {
        case .sharePosition(let parameters):
            let encoded = try? JSONEncoder().encode(parameters)
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
        let token = KeychainWrapper.standard.string(forKey: KeychainKeys.token.rawValue) ?? ""
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            urlRequest.httpBody = parameters
        }
        
        return urlRequest
    }
}
