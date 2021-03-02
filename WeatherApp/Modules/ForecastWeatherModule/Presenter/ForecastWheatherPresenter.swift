//
//  ForecastWheatherPresenter.swift
//  WeatherApp
//
//  Created by Vlad Novik on 1.03.21.
//

import Foundation

protocol ForecastWeatherViewPresenterProtocol: class {
    func showForecastWeather()
}

class ForecastWheatherPresenter: WeatherPresenter, ForecastWeatherViewPresenterProtocol {
    func showForecastWeather() {
        
    }
}
