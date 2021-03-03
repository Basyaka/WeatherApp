//
//  ForecastWheatherPresenter.swift
//  WeatherApp
//
//  Created by Vlad Novik on 1.03.21.
//

import Foundation

protocol ForecastWeatherViewPresenterProtocol: class {
    func showForecastWeather()
    var forecastWeather: ForecastWeatherData? { get set }
    var forecastWeatherModel: ForecastWeatherModel? { get set }
}

class ForecastWheatherPresenter: WeatherPresenter, ForecastWeatherViewPresenterProtocol {
    var forecastWeather: ForecastWeatherData?
    var forecastWeatherModel: ForecastWeatherModel?
    
    func showForecastWeather() {
        guard let currentLocation = locationService.getCurrentLocation() else { return }
        print("Transfer loc to net request \(currentLocation)")
        networkService.request(router: Router.getForecast(lat: currentLocation.lat, lon: currentLocation.lon)) { (result: Result<ForecastWeatherData, Error>) in
            switch result {
            case .success(let forecastWeather):
                self.forecastWeather = forecastWeather
                self.view?.success()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
}
