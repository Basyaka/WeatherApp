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
        let forecastWeatherVC = ModuleBuilder.createForecastWeatherModule()
        
        viewControllers = [
            generateNavigationController(viewController: currentWeatherVC, title: "Today", image: UIImage(systemName: "sun.max")!),
            generateNavigationController(viewController: forecastWeatherVC, title: "Forecast", image: UIImage(systemName: "cloud.moon")!)
        ]
    }
    
    private func generateNavigationController(viewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navVC = UINavigationController(rootViewController: viewController)
        navVC.tabBarItem.title = title
        navVC.tabBarItem.image = image
        return navVC
    }
}
