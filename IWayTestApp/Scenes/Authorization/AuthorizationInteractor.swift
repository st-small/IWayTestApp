//
//  AuthorizationInteractor.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/18/19.
//  Copyright (c) 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

public protocol AuthorizationBusinessLogic {
    func makeRequest(_ request: Authorization.Model.Request)
}

public protocol AuthorizationDataStore {
    //var name: String { get set }
}

public class AuthorizationInteractor: AuthorizationBusinessLogic, AuthorizationDataStore {
    
    // MARK: - Services
    private let apiClient: APIAuthorizationClient = ApplicationDependency.container.resolve()
    
    // MARK: - Data
    var presenter: AuthorizationPresentationLogic?
    
    // MARK: - Main logic
    public func makeRequest(_ request: Authorization.Model.Request) {
        switch request {
        case .login(let login, let password):
            guard fieldValidation(login) else {
                presenter?.presentData(response: .emptyField(.login))
                return
            }
            guard fieldValidation(password) else {
                presenter?.presentData(response: .emptyField(.password))
                return
            }
            
            let device =
                Device(os: getSystemInfo(),
                       appVersion: getAppInfo(),
                       hardwareId: UUID().uuidString)
            let params = AuthRequest(login: login, password: password, deviceInfo: device)
            apiClient.driverAuth(parameters: params) { [weak self] (result) in
                switch result {
                case .success(let response):
                    guard let result = response.result else {
                        self?.presenter?.presentData(response: .fail("Something went wrong..."))
                        return
                    }
                    self?.save(result)
                    self?.presenter?.presentData(response: .success)
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.presenter?.presentData(response: .fail(error.localizedDescription))
                }
            }
        }
    }
    
    private func fieldValidation(_ value: String) -> Bool {
        return !value.isEmpty
    }
    
    private func getSystemInfo() -> String {
        return UIDevice.current.systemVersion
    }
    
    private func getAppInfo() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String
        return version + "(" + build + ")"
    }
    
    private func save(_ tokens: Result) {
        
    }
}
