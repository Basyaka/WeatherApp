//
//  ForecastWeatherViewController.swift
//  WeatherApp
//
//  Created by Vlad Novik on 1.03.21.
//

import UIKit

class ForecastWeatherViewController: UIViewController {
    
    weak var presenter: ForecastWeatherViewPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        super.tabBarController?.title = "Forecast"
        view.backgroundColor = .yellow
    }
}

extension ForecastWeatherViewController: WeatherViewProtocol {
    func success() {
        
    }
    
    func failure(error: Error) {
        
    }
    
    func getLocation() {
        
    }
}
