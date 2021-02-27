//
//  ModuleBuilder.swift
//  WeatherApp
//
//  Created by Vlad Novik on 27.02.21.
//

import UIKit

protocol Builder {
    static func createCurrentWeatherModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createCurrentWeatherModule() -> UIViewController {
        let model = CurrentWeatherModel(currentTemp: "+3")
        let view = CurrentWeatherViewController()
        let presenter = CurrentWeatherPresenter(view: view, currentWeather: model)
        view.presenter = presenter
        return view
    }
}
