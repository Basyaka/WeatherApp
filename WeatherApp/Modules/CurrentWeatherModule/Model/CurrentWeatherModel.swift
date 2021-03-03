//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Vlad Novik on 2.03.21.
//

import Foundation

struct CurrentWeatherModel {
    let id: Int
    let weatherName: String
    let cityName: String
    let countryName: String
    let temperature: Double
    let pressure: Double
    let humidity: Double
    let speed: Double
    let deg: Double
    let amountOfRain: Double
    
    init?(currentWeatherData current: CurrentWeatherData) {
        self.id = current.weather[0].id
        self.weatherName = current.weather[0].main
        self.cityName = current.name ?? " "
        self.countryName = current.sys.country ?? " "
        self.temperature = current.main.temp
        self.pressure = current.main.pressure
        self.humidity = current.main.humidity
        self.speed = current.wind.speed
        self.deg = current.wind.deg
        self.amountOfRain = current.rain?.the1H ?? 0
    }
    
    var conditionName: String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    var windDirection: String {
        switch deg {
        case 22.5...67.4:
            return "NE"
        case 67.5...122.4:
            return "E"
        case 122.5...157.4:
            return "SE"
        case 157.5...202.4:
            return "S"
        case 202.5...247.4:
            return "SW"
        case 247.5...292.4:
            return "W"
        case 292.5...337.4:
            return "NW"
        default:
            return "N"
        }
    }
    
    var temperatureString: String {
        let temp = String(format: "%.0f", temperature)
        return "\(temp)°С"
    }
    
    var pressureString: String {
        let pressure = String(format: "%.0f", self.pressure)
        return "\(pressure) hPa"
    }
    
    var windSpeedString: String {
        let kmhspeed = speed*3.529
        let speed = String(format: "%.0f", kmhspeed)
        return "\(speed) km/h"
    }
    
    var humidityString: String {
        let humidity = String(format: "%.0f", self.humidity)
        return "\(humidity)%"
    }
    
    var locationName: String {
        return "\(cityName), \(countryName)"
    }
    
    var amountOfRainString: String {
        let rain = String(format: "%.1f", amountOfRain)
        return "\(rain) mm"
    }
    
    lazy var collectionInfoArray = [humidityString, amountOfRainString, pressureString, windSpeedString, windDirection]
    let collectionImageStringArray = ["cloud.rain", "cloud.heavyrain", "thermometer", "wind", "chevron.right.circle"]
}
