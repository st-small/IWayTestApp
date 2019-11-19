//
//  EnvironmentInterceptor.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/18/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import Alamofire

public struct EnvironmentInterceptor: RequestInterceptor {
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (AFResult<URLRequest>) -> Void) {
        var adaptedRequest = urlRequest
//        guard let token = KeychainWrapper.standard.string(forKey: KeychainsKeys.token.rawValue) else {
//            completion(.success(adaptedRequest))
//            return
//        }
//        adaptedRequest.setValue("Bearer \(token)", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        completion(.success(adaptedRequest))
    }
    
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            //get token
            
//            guard let refreshToken = KeychainWrapper.standard.string(forKey: KeychainsKeys.refreshToken.rawValue) else {
//                completion(.doNotRetryWithError(error))
//                return
//            }
            
//            APIDriverAcountClient.refreshToken(refreshToken: refreshToken) { res in
//                switch res {
//                case .success(let response):
//                    let saveAccessToken: Bool = KeychainWrapper.standard.set(response.accessToken, forKey: KeychainsKeys.token.rawValue)
//                    let saveRefreshToken: Bool = KeychainWrapper.standard.set(response.refreshToken, forKey: KeychainsKeys.refreshToken.rawValue)
//                    let saveUserId: Bool = KeychainWrapper.standard.set(response.userId, forKey: KeychainsKeys.uId.rawValue)
//                    print("is accesstoken saved ?: \(saveAccessToken)")
//                    print("is refreshToken saved ?: \(saveRefreshToken)")
//                    print("is userID saved ?: \(saveUserId)")
//                    completion(.retry)
//                    break
//                case .failure(let err):
//                    //TODO logout
//                    break
//                    
//                }
//                
//            }
        } else {
            completion(.doNotRetry)
        }
    }
}
