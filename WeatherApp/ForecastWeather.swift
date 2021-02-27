//
//  ForecastWeather.swift
//  WeatherApp
//
//  Created by Vlad Novik on 28.02.21.
//

import Foundation

// MARK: - Person
struct ForecastPerson: Codable {
    let cod: String
    let message, cnt: Int
    let list: [ForecastList]
    let city: ForecastCity
}

// MARK: - City
struct ForecastCity: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct ForecastCoord: Codable {
    let lat, lon: Double
}

// MARK: - List
struct ForecastList: Codable {
    let dt: Int
    let main: MainClass
    let weather: [ForecastWeather]
    let clouds: ForecastClouds
    let wind: ForecastWind
    let visibility: Int
    let pop: Double
    let sys: ForecastSys
    let dtTxt: String
    let snow, rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case snow, rain
    }
}

// MARK: - Clouds
struct ForecastClouds: Codable {
    let all: Int
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct ForecastSys: Codable {
    let pod: Pod
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct ForecastWeather: Codable {
    let id: Int
    let main: MainEnum
    let weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case snow = "Snow"
}

// MARK: - Wind
struct ForecastWind: Codable {
    let speed: Double
    let deg: Int
}
