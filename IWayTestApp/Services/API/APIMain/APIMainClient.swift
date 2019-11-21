//
//  APIMainClient.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/19/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import Alamofire

public protocol APIMainClient: class {
    func sharePosition(parameters: [CoordinatesRequest], completion: @escaping (AFResult<CoordinatesResult>) -> ())
}

public class APIMainClientImpl: APIMainClient {
    
    @discardableResult
    private func performRequest<T: Decodable>(route: APIMainRouter, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (AFResult<T>)->()) -> DataRequest {
        return AF.request(route, interceptor: EnvironmentInterceptor())
            .responseDecodable (decoder: decoder){ (response: AFDataResponse<T>) in
                completion(response.result)
        }
    }
    
    public func sharePosition(parameters: [CoordinatesRequest], completion: @escaping (AFResult<CoordinatesResult>) -> ()) {
        performRequest(route: APIMainRouter.sharePosition(parameters), completion: completion)
    }
}
