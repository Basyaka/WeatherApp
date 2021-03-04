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
    func startUpdatingLocation()
    func updateInfo()
    var currentWeather: CurrentWeatherData? { get set }
    var currentWeatherModel: CurrentWeatherModel? { get set }
}

class WeatherPresenter: CurrentWeatherViewPresenterProtocol {
    weak var view: WeatherViewProtocol?
    let networkService: NetworkServiceProtocol!
    let locationService: LocationService!
    var currentWeather: CurrentWeatherData?
    var currentWeatherModel: CurrentWeatherModel?
    var currentLocation: Location? {
        didSet {
            showCurrentWeather()
        }
    }
    
    required init(view: WeatherViewProtocol, networkService: NetworkServiceProtocol, locationService: LocationService) {
        self.view = view
        self.networkService = networkService
        self.locationService = locationService
        startUpdatingLocation()
    }
    
    private func showCurrentWeather() {
        guard let currentLocation = currentLocation else { return }
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
        //Nortification
//        updateInfo()
    }
    
    func updateInfo() {
        currentLocation = locationService.getCurrentLocation()
    }
}


