//
//  CurrentWeatherData.swift
//  WeatherApp
//
//  Created by Vlad Novik on 27.02.21.
//

// MARK: - CurrentWeatherData
struct CurrentWeatherData: Decodable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let sys: Sys
    let rain: Rain?
    let name: String?
}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int
    let main: String
}

// MARK: - Main
struct Main: Decodable {
    let temp: Double
    let pressure, humidity: Double
}

// MARK: - Wind
struct Wind: Decodable {
    let speed, deg: Double
}

// MARK: - Sys
struct Sys: Decodable {
    let country: String?
}

//MARK: - Rain
struct Rain: Decodable {
    let the1H: Double?
    
    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}
