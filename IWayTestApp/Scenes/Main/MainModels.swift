//
//  MainModels.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/19/19.
//  Copyright (c) 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

public enum Main {
    public enum Model {
        public enum Request {
            case sharePosition
        }
        public enum Response {
            case pointShared(_ models: [MainModelResponse])
            case fail(_ error: String)
        }
        public enum ViewModel {
            case pointShared(_ models: [MainModelResponse])
            case fail(_ error: String)
        }
    }
}

public struct MainModelResponse {
    public let coordinates: Coords
    public let cityName: String
    public let date: String
}

// MARK: - Local JSON Coordinates Response
public struct CoordinatesJSONResponse: Decodable {
    public let coords: Coords?
    public let district: String?
    public let name: String
    public let population: Int?
    public let subject: String?
}

// MARK: - Coords
public struct Coords: Decodable {
    public let lat: String
    public let lon: String
}

// MARK: - CoordinatesRequestElement
public struct CoordinatesRequest: Encodable {
    public let point: Point
    public let speed: Float
    public let type: Int
    public let sent: String
}

// MARK: - Point
public struct Point: Encodable {
    public let lat: Double
    public let lng: Double
}

public struct CoordinatesResult: Decodable {
    public let result: Bool?
}
