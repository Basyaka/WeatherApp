//
//  ForecastWeatherData.swift
//  WeatherApp
//
//  Created by Vlad Novik on 28.02.21.
//

import Foundation

// MARK: - Person
struct ForecastWeatherData: Decodable {
    let list: [ForecastList]
}

// MARK: - List
struct ForecastList: Decodable {
    let main: MainClass
    let weather: [ForecastWeather]
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case main, weather
        case dtTxt = "dt_txt"
    }
}

// MARK: - MainClass
struct MainClass: Decodable {
    let temp: Double
}

// MARK: - Weather
struct ForecastWeather: Decodable {
    let id: Int
    let main: String
}
