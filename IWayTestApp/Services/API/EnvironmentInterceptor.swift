//
//  EnvironmentInterceptor.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/18/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import Alamofire

public struct EnvironmentInterceptor: RequestInterceptor {
    
    private let apiClient: APIAuthorizationClient = ApplicationDependency.container.resolve()
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (AFResult<URLRequest>) -> Void) {
        var adaptedRequest = urlRequest
        guard let token = KeychainWrapper.standard.string(forKey: KeychainKeys.token.rawValue) else {
            completion(.success(adaptedRequest))
            return
        }
        adaptedRequest.setValue("Bearer \(token)", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        completion(.success(adaptedRequest))
    }
}
