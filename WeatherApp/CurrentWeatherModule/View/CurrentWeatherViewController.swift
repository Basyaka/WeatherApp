//
//  CurrentWeatherViewController.swift
//  WeatherApp
//
//  Created by Vlad Novik on 27.02.21.
//

import UIKit

class CurrentWeatherViewController: UIViewController {
    
    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        label.textAlignment = .center
        return label
    }()
    
    var presenter: CurrentWeatherViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.showCurrentWeather()
        
        setLayout()
        view.backgroundColor = .white
    }
    
    func setLayout() {
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: 100),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension CurrentWeatherViewController: CurrentWeatherViewProtocol {
    func setCurrentWeather(weather: String) {
        self.label.text = weather
    }
}
