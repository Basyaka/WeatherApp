//
//  CurrentWeatherData.swift
//  WeatherApp
//
//  Created by Vlad Novik on 27.02.21.
//

// MARK: - CurrentWeatherData
struct CurrentWeatherData: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let sys: Sys
    let name: String
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
    let pressure, humidity: Double
}

// MARK: - Wind
struct Wind: Codable {
    let speed, deg: Double
}

// MARK: - Sys
struct Sys: Codable {
    let country: String?
}