//
//  ModuleBuilder.swift
//  WeatherApp
//
//  Created by Vlad Novik on 27.02.21.
//

import UIKit

protocol Builder {
    static func createCurrentWeatherModule() -> UIViewController
    static func createForecastWeatherModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createCurrentWeatherModule() -> UIViewController {
        let view = CurrentWeatherViewController()
        let networkService = NetworkService()
        let locationService = LocationService()
        let presenter = WeatherPresenter(view: view, networkService: networkService, locationService: locationService)
        view.presenter = presenter
        return view
    }
    
    static func createForecastWeatherModule() -> UIViewController {
        let view = ForecastWeatherViewController()
        let networkService = NetworkService()
        let locationService = LocationService()
        let presenter = ForecastWheatherPresenter(view: view, networkService: networkService, locationService: locationService)
        view.presenter = presenter
        return view
    }
}
