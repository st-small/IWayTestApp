//
//  AuthorizationModels.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/18/19.
//  Copyright (c) 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

public enum FieldType {
    case login
    case password
}

public enum Authorization {
    public enum Model {
        public enum Request {
            case login(_ login: String, _ password: String)
        }
        public enum Response {
            case emptyField(_ type: FieldType)
            case fail(_ error: String)
            case success
        }
        public enum ViewModel {
            case emptyField(_ type: FieldType)
            case fail(_ error: String)
            case success
        }
    }
}

// MARK: - Request
public struct AuthRequest: Encodable {
    public let login: String
    public let password: String
    public let deviceInfo: Device
}

public struct Device: Encodable {
    public let os: String
    public let appVersion: String
    public let hardwareId: String
}

// MARK: - Response
public struct Response: Decodable {
    public let result: Result?
    public let error: Error?
}

// MARK: - Result
public struct Result: Decodable {
    public let token: String
    public let refreshToken: String
}

// MARK: - Error
public struct Error: Decodable {
    public let name: String
    public let message: String
    public let code: Int
    public let status: Int
    public let type: String
}
