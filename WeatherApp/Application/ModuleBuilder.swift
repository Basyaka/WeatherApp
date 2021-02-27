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
        let view = CurrentWeatherViewController()
        let networkService = NetworkService()
        let presenter = CurrentWeatherPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
}
