//
//  Router.swift
//  WeatherApp
//
//  Created by Vlad Novik on 27.02.21.
//

import Foundation

enum Router {
    case getCurrentWeather(lat: Double, lon: Double)
    case getForecast(lat: Double, lon: Double)
    
    var scheme: String {
        switch self {
        case .getCurrentWeather, .getForecast:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .getCurrentWeather, .getForecast:
            return "api.openweathermap.org"
        }
    }
    
    var path: String {
        switch self {
        case .getCurrentWeather:
            return "/data/2.5/weather"
        case .getForecast:
            return "/data/2.5/forecast"
        }
    }
    
    var parameters: [URLQueryItem] {
        let appid = "0797492c4509ad4dc15002cb1ff33103"
        let units = "metric"
        switch self {
        case .getCurrentWeather(let lat, let lon):
          return [URLQueryItem(name: "lat", value: "\(lat)"),
                  URLQueryItem(name: "lon", value: "\(lon)"),
                  URLQueryItem(name: "units", value: units),
                  URLQueryItem(name: "appid", value: appid)]
        case .getForecast(let lat, let lon):
          return [URLQueryItem(name: "lat", value: "\(lat)"),
                  URLQueryItem(name: "lon", value: "\(lon)"),
                  URLQueryItem(name: "units", value: units),
                  URLQueryItem(name: "appid", value: appid)]
        }
      }
}
