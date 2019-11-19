//
//  APIAuthorizationClient.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/18/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import Alamofire

public protocol APIAuthorizationClient: class {
    func driverAuth(parameters: AuthRequest, completion: @escaping (AFResult<Response>) -> ())
}

public class APIAuthorizationClientImpl: APIAuthorizationClient {
    
    @discardableResult
    private func performRequest<T: Decodable>(route: APIAuthorizationRouter, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (AFResult<T>)->()) -> DataRequest {
        
        return AF.request(route, interceptor: EnvironmentInterceptor())
            .responseDecodable (decoder: decoder){ (response: AFDataResponse<T>) in
                completion(response.result)
        }
    }
    
    public func driverAuth(parameters: AuthRequest, completion: @escaping (AFResult<Response>) -> ()) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        performRequest(route: APIAuthorizationRouter.driverAuth(parameters), decoder: decoder, completion: completion)
    }
}
