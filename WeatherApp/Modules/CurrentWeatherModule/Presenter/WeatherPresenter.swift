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
    init(view: WeatherViewProtocol, networkService: NetworkServiceProtocol, locationService: LocationServiceProtocol, storageService: StorageServiceProtocol)
    func startUpdatingLocation()
    func showCurrentWeather()
    var currentWeather: CurrentWeatherData? { get set }
    var currentWeatherModel: CurrentWeatherModel? { get set }
    var currentWeatherStorageModel: CurrentWeatherStorageModel? { get set }
}

class WeatherPresenter: CurrentWeatherViewPresenterProtocol {
    weak var view: WeatherViewProtocol?
    let networkService: NetworkServiceProtocol!
    let locationService: LocationServiceProtocol!
    let storageService: StorageServiceProtocol!
    var currentWeather: CurrentWeatherData?
    var currentWeatherModel: CurrentWeatherModel?
    var currentWeatherStorageModel: CurrentWeatherStorageModel?
    
    required init(view: WeatherViewProtocol, networkService: NetworkServiceProtocol, locationService: LocationServiceProtocol, storageService: StorageServiceProtocol) {
        self.view = view
        self.networkService = networkService
        self.locationService = locationService
        self.storageService = storageService
        locationService.startUpdatingLocation()
    }
    
    func showCurrentWeather() {
        guard let currentLocation = locationService.getCurrentLocation() else { return }
        networkService.request(router: Router.getCurrentWeather(lat: currentLocation.lat, lon: currentLocation.lon)) { [self] (result: Result<CurrentWeatherData, Error>) in
            switch result {
            case .success(let currentWeather):
                self.currentWeather = currentWeather
                self.currentWeatherModel = CurrentWeatherModel(currentWeatherData: currentWeather)
                storageService.deleteCurrentWeatherStorageObject()
                guard let currentWeatherModel = currentWeatherModel else { return }
                storageService.createCurrentWeatherStorageObject(currentWeather: currentWeatherModel)
                self.view?.success()
            case .failure(let error):
                self.currentWeatherStorageModel = storageService.getAllCurrentWeatherStorageModel()?.first
                self.view?.failure(error: error)
            }
        }
    }
    
    func startUpdatingLocation() {
        locationService.startUpdatingLocation()
    }
}


