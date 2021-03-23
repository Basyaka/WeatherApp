//
//  ForecastWeatherModel.swift
//  WeatherApp
//
//  Created by Vlad Novik on 3.03.21.
//

import Foundation

struct ForecastWeatherModel {
    let forecastList: [ForecastList]
    
    private let dateFormatterGet = DateFormatter()
    private let dateFormatterResult = DateFormatter()
    
    init(forecastWeatherData forecast: ForecastWeatherData) {
        forecastList = forecast.list
    }
    
    var timeArray: [String] {
        var timeArr = [String]()
        for item in forecastList {
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatterResult.dateFormat = "E, dd-MM HH:mm"
            let time = dateFormatterResult.string(from: dateFormatterGet.date(from: item.dtTxt)!)
            timeArr.append(time)
        }
        return timeArr
    }
    
    var weatherNameArray: [String] {
        var nameArr = [String]()
        for forecastItem in forecastList {
            for weatherItem in forecastItem.weather {
                nameArr.append(weatherItem.main)
            }
        }
        return nameArr
    }
    
    var conditionNameArray: [String] {
        var conditionName = [String]()
        for forecastItem in forecastList {
            for idItem in forecastItem.weather {
                switch idItem.id {
                case 200...232:
                    conditionName.append("cloud.bolt")
                case 300...321:
                    conditionName.append("cloud.drizzle")
                case 500...531:
                    conditionName.append("cloud.rain")
                case 600...622:
                    conditionName.append("cloud.snow")
                case 701...781:
                    conditionName.append("cloud.fog")
                case 800:
                    conditionName.append("sun.max")
                default:
                    conditionName.append("cloud")
                }
            }
        }
        return conditionName
    }
    
    var temperatureArray: [String] {
        var tempArray = [String]()
        for forecastItem in forecastList {
            let temp = String(format: "%.0f", forecastItem.main.temp)
            tempArray.append("\(temp)°")
        }
        return tempArray
    }
}
