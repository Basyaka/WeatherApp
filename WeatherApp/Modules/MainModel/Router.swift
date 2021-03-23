//
//  Router.swift
//  WeatherApp
//
//  Created by Vlad Novik on 27.02.21.
//

import Foundation

struct DefaultRouterOptions {
    static let scheme = "https"
    static let host = "api.openweathermap.org"
    
    fileprivate static let appid = "0797492c4509ad4dc15002cb1ff33103"
    fileprivate static let units = "metric"
}

enum Router {
    case getCurrentWeather(lat: Double, lon: Double)
    case getForecast(lat: Double, lon: Double)
    
    var path: String {
        switch self {
        case .getCurrentWeather:
            return "/data/2.5/weather"
        case .getForecast:
            return "/data/2.5/forecast"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getCurrentWeather(let lat, let lon):
          return [URLQueryItem(name: "lat", value: "\(lat)"),
                  URLQueryItem(name: "lon", value: "\(lon)"),
                  URLQueryItem(name: "units", value: DefaultRouterOptions.units),
                  URLQueryItem(name: "appid", value: DefaultRouterOptions.appid)]
        case .getForecast(let lat, let lon):
          return [URLQueryItem(name: "lat", value: "\(lat)"),
                  URLQueryItem(name: "lon", value: "\(lon)"),
                  URLQueryItem(name: "units", value: DefaultRouterOptions.units),
                  URLQueryItem(name: "appid", value: DefaultRouterOptions.appid)]
        }
      }
}
