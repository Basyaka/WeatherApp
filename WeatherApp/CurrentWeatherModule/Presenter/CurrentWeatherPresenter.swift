//
//  CurrentWeatherPresenter.swift
//  WeatherApp
//
//  Created by Vlad Novik on 27.02.21.
//

import Foundation

protocol CurrentWeatherViewProtocol: class {
    func setCurrentWeather(weather: String)
}

protocol CurrentWeatherViewPresenterProtocol: class {
    init(view: CurrentWeatherViewProtocol, currentWeather: CurrentWeatherModel)
    func showCurrentWeather()
}

class CurrentWeatherPresenter: CurrentWeatherViewPresenterProtocol {
    let view: CurrentWeatherViewProtocol
    let currentWeather: CurrentWeatherModel
    
    required init(view: CurrentWeatherViewProtocol, currentWeather: CurrentWeatherModel) {
        self.view = view
        self.currentWeather = currentWeather
    }
    
    func showCurrentWeather() {
        let weather = currentWeather.currentTemp
        view.setCurrentWeather(weather: weather)
    }
}
