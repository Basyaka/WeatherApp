//
//  ForecastWheatherPresenter.swift
//  WeatherApp
//
//  Created by Vlad Novik on 1.03.21.
//

import Foundation

protocol ForecastWeatherViewPresenterProtocol: class {
    func showForecastWeather()
    func startUpdateLocation()
    var forecastWeather: ForecastWeatherData? { get set }
    var forecastWeatherModel: ForecastWeatherModel? { get set }
    var forecastWeatherStorageModel: ForecastWeatherStorageModel? { get set }
}

class ForecastWheatherPresenter: WeatherPresenter, ForecastWeatherViewPresenterProtocol {
    var forecastWeather: ForecastWeatherData?
    var forecastWeatherModel: ForecastWeatherModel?
    var forecastWeatherStorageModel: ForecastWeatherStorageModel?
    
    func showForecastWeather() {
        guard let currentLocation = locationService.getCurrentLocation() else { return }
        networkService.request(router: Router.getForecast(lat: currentLocation.lat, lon: currentLocation.lon)) { [weak self] (result: Result<ForecastWeatherData, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let forecastWeather):
                self.forecastWeather = forecastWeather
                self.forecastWeatherModel = ForecastWeatherModel(forecastWeatherData: forecastWeather)
                self.storageService.deleteForecastWeatherStorageObject()
                guard let forecastWeatherModel = self.forecastWeatherModel else { return }
                self.storageService.createForecastWeatherStorageObject(forecastWeather: forecastWeatherModel)
                self.view?.success()
            case .failure(let error):
                self.forecastWeatherStorageModel = self.storageService.getAllForecastWeatherStorageModel()?.first
                self.view?.failure(error: error)
            }
        }
    }
    
    func startUpdateLocation() {
        startUpdatingLocation()
    }
}
