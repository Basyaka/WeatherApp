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
    private static let networkService = NetworkService()
    private static let locationService = LocationService()
    private static let storageService = StorageService()
    
    static func createCurrentWeatherModule() -> UIViewController {
        let view = CurrentWeatherViewController()
        let presenter = WeatherPresenter(view: view, networkService: networkService, locationService: locationService, storageService: storageService)
        view.presenter = presenter
        return view
    }
    
    static func createForecastWeatherModule() -> UIViewController {
        let view = ForecastWeatherViewController()
        let presenter = ForecastWheatherPresenter(view: view, networkService: networkService, locationService: locationService, storageService: storageService)
        view.presenter = presenter
        return view
    }
}
