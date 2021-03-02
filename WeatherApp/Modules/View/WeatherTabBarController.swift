//
//  WeatherTabBarController.swift
//  WeatherApp
//
//  Created by Vlad Novik on 2.03.21.
//

import UIKit

class WeatherTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let currentWeatherVC = ModuleBuilder.createCurrentWeatherModule()
        currentWeatherVC.tabBarItem = UITabBarItem(title: "Today", image: UIImage(systemName: "sun.max"), tag: 0)
        
        let forecastWeatherVC = ModuleBuilder.createForecastWeatherModule()
        forecastWeatherVC.tabBarItem = UITabBarItem(title: "Forecast", image: UIImage(systemName: "cloud.moon"), tag: 1)
        
        let tabBarList = [currentWeatherVC, forecastWeatherVC]
        
        viewControllers = tabBarList
    }
}
