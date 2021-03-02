//
//  ForecastWeatherData.swift
//  WeatherApp
//
//  Created by Vlad Novik on 28.02.21.
//

import Foundation

// MARK: - Person
struct ForecastWeatherData: Codable {
    let list: [ForecastList]
}

// MARK: - List
struct ForecastList: Codable {
    let main: MainClass
    let weather: [ForecastWeather]
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case main, weather
        case dtTxt = "dt_txt"
    }
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp: Double
}

// MARK: - Weather
struct ForecastWeather: Codable {
    let id: Int
    let main: MainEnum
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case snow = "Snow"
}

