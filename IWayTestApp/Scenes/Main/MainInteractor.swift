//
//  MainInteractor.swift
//  IWayTestApp
//
//  Created by Станислав Шияновский on 11/19/19.
//  Copyright (c) 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

public protocol MainBusinessLogic {
    func makeRequest(_ request: Main.Model.Request)
}

public protocol MainDataStore { }

public class MainInteractor: MainBusinessLogic, MainDataStore {
    
    // MARK: - Data
    private var cities = [CoordinatesJSONResponse]()
    private var currentCity: CoordinatesJSONResponse?
    
    var presenter: MainPresentationLogic?
    
    // MARK: - Services
    private let apiClient: APIMainClient = ApplicationDependency.container.resolve()
    
    // MARK: - Main logic
    public func makeRequest(_ request: Main.Model.Request) {
        switch request {
        case .sharePosition:
            getRandomCitiesValues()
            sharePosition()
        }
    }
    
    private func getRandomCitiesValues() {
        guard cities.isEmpty else { return }
        guard let url = Bundle.main.url(forResource: "russian-cities", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                presenter?.presentData(.fail("Can't get random city!"))
                return
        }
        do {
           let cities = try JSONDecoder().decode([CoordinatesJSONResponse].self, from: data)
            self.cities = cities
        } catch {
            let error = error.localizedDescription
            presenter?.presentData(.fail(error))
        }
    }
    
    private func sharePosition() {
        guard
            let city = cities.randomElement(),
            let coords = city.coords else {
            presenter?.presentData(.fail("Can't get random city!"))
            return
        }
        currentCity = city

        let latitude = NumberFormatter().number(from: coords.lat)?.doubleValue ?? 0
        let longitude = NumberFormatter().number(from: coords.lon)?.doubleValue ?? 0
        let point = Point(lat: latitude, lng: longitude)
        let speed = Float.random(in: 0..<90.0)
        let date = Date().serverFormatDate()
        let request = [CoordinatesRequest(point: point, speed: speed, type: 1, sent: date)]
        
        apiClient.sharePosition(parameters: request) { [weak self] (result) in
            switch result {
            case .success(_):
                let model = MainModelResponse(coordinates: coords,
                                              cityName: city.name, date: date)
                self?.presenter?.presentData(.pointShared(model))
                self?.currentCity = nil
            case .failure(let error):
                let error = error.localizedDescription
                self?.presenter?.presentData(.fail(error))
            }
        }
    }
}
