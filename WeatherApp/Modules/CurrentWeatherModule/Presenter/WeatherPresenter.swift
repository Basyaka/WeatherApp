//
//  CurrentWeatherPresenter.swift
//  WeatherApp
//
//  Created by Vlad Novik on 27.02.21.
//

import Foundation

protocol WeatherViewProtocol: class {
    func success()
    func failure(error: Error)
}

protocol CurrentWeatherViewPresenterProtocol: class {
    init(view: WeatherViewProtocol, networkService: NetworkServiceProtocol, locationService: LocationService)
    func showCurrentWeather()
    func startUpdatingLocation()
    var currentWeather: CurrentWeatherData? { get set }
}

class WeatherPresenter: CurrentWeatherViewPresenterProtocol {
    private weak var view: WeatherViewProtocol?
    private let networkService: NetworkServiceProtocol!
    private let locationService: LocationService!
    var currentWeather: CurrentWeatherData?
    
    required init(view: WeatherViewProtocol, networkService: NetworkServiceProtocol, locationService: LocationService) {
        self.view = view
        self.networkService = networkService
        self.locationService = locationService
        startUpdatingLocation()
    }
    
    func showCurrentWeather() {
        guard let currentLocation = locationService.getCurrentLocation() else { return }
        print("Transfer loc to net request \(currentLocation)")
        networkService.request(router: Router.getCurrentWeather(lat: currentLocation.lat, lon: currentLocation.lon)) { (result: Result<CurrentWeatherData, Error>) in
            switch result {
            case .success(let currentWeather):
                self.currentWeather = currentWeather
                self.view?.success()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
    
    func startUpdatingLocation() {
        locationService.startUpdatingLocation()
    }
}


