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
    
    private var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    weak var presenter: CurrentWeatherViewPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: 100),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func buttonTapped() {
        presenter?.showCurrentWeather()
    }
}

extension CurrentWeatherViewController: CurrentWeatherViewProtocol {
    func success() {
        label.text = presenter?.currentWeather?.name
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
