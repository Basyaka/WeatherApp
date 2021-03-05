//
//  CurrentWeatherStorageModel.swift
//  WeatherApp
//
//  Created by Vlad Novik on 5.03.21.
//

import Foundation

struct CurrentWeatherStorageModel {
    var conditionName,
        windDirection,
        temperatureAndWeatherNameString,
        pressureString,
        windSpeedString,
        humidityString,
        locationName,
        amountOfRainString: String?
    
    lazy var collectionInfoArray = [humidityString, amountOfRainString, pressureString, windSpeedString, windDirection]
}
