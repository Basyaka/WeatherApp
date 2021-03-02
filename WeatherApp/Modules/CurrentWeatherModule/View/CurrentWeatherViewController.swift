//
//  CurrentWeatherViewController.swift
//  WeatherApp
//
//  Created by Vlad Novik on 27.02.21.
//

import UIKit
import CoreLocation

class CurrentWeatherViewController: UIViewController {
    
    private var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "sun.max")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont(name: label.font.fontName, size: 20)
        label.text = "Minsk, BY"
        return label
    }()
    
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .systemBlue
        label.text = "5C"
        label.font = UIFont(name: label.font.fontName, size: 30)
        return label
    }()
    
    private var weatherInfoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .systemBlue
        label.text = "Sunny"
        label.font = UIFont(name: label.font.fontName, size: 30)
        return label
    }()
    
//    private var humidityLabel = WeatherInfoLabel()
//    private var amountOfRainLabel = WeatherInfoLabel()
//    private var pressureLabel = WeatherInfoLabel()
//    private var windSpeedLabel = WeatherInfoLabel()
//    private var windDirectionLabel = WeatherInfoLabel()
    
    private var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: CurrentWeatherViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        super.tabBarController?.title = "Today"
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        
        let stackForImageIconAndLocation = UIStackView(arrangedSubviews: [weatherIcon, locationLabel])
        stackForImageIconAndLocation.axis = .vertical
        stackForImageIconAndLocation.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackForImageIconAndLocation)
        NSLayoutConstraint.activate([
            weatherIcon.heightAnchor.constraint(equalTo: stackForImageIconAndLocation.heightAnchor, multiplier: 0.7),
            locationLabel.heightAnchor.constraint(equalTo: stackForImageIconAndLocation.heightAnchor, multiplier: 0.3)
        ])
        
        let stackForTempAndWeatherInfo = UIStackView(arrangedSubviews: [temperatureLabel, weatherInfoLabel])
        stackForTempAndWeatherInfo.distribution = .fillEqually
        stackForTempAndWeatherInfo.spacing = 20
        
        let mainInfoStack = UIStackView(arrangedSubviews: [stackForImageIconAndLocation, stackForTempAndWeatherInfo])
        mainInfoStack.translatesAutoresizingMaskIntoConstraints = false
        mainInfoStack.axis = .vertical
        
        view.addSubview(mainInfoStack)
        NSLayoutConstraint.activate([
            stackForImageIconAndLocation.heightAnchor.constraint(equalTo: mainInfoStack.heightAnchor, multiplier: 0.8),
            stackForTempAndWeatherInfo.heightAnchor.constraint(equalTo: mainInfoStack.heightAnchor, multiplier: 0.2),
                                        
            mainInfoStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            stackForImageIconAndLocation.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),

            mainInfoStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            mainInfoStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
//        let humidityView = WeatherInfoView(imageName: "cloud.rain", label: humidityLabel)
//        let amountOfRainView = WeatherInfoView(imageName: "cloud.heavyrain", label: amountOfRainLabel)
//        let pressureView = WeatherInfoView(imageName: "thermometer", label: pressureLabel)
//        let windSpeedView = WeatherInfoView(imageName: "wind", label: windSpeedLabel)
//        let windDirectionView = WeatherInfoView(imageName: "chevron.right.circle", label: windDirectionLabel)
//
//        let firstLvlInfoWeatherStack = UIStackView(arrangedSubviews: [humidityView, amountOfRainView, pressureView])
//        firstLvlInfoWeatherStack.distribution = .fillEqually
//
//        let secondLvlInfoWeatherStack = UIStackView(arrangedSubviews: [windSpeedView, windDirectionView])
//        secondLvlInfoWeatherStack.distribution = .fillEqually
//
//        let infoWeatherStack = UIStackView(arrangedSubviews: [firstLvlInfoWeatherStack, secondLvlInfoWeatherStack])
//        infoWeatherStack.translatesAutoresizingMaskIntoConstraints = false
//        infoWeatherStack.axis = .vertical
//        infoWeatherStack.distribution = .fillEqually
//
//        view.addSubview(infoWeatherStack)
//        NSLayoutConstraint.activate([
//            infoWeatherStack.topAnchor.constraint(equalTo: mainInfoStack.bottomAnchor, constant: 30),
//            infoWeatherStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            infoWeatherStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            infoWeatherStack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
        
    }
    @objc private func buttonTapped() {
        presenter.showCurrentWeather()
    }
}

extension CurrentWeatherViewController: WeatherViewProtocol {    
    func success() {
        guard let currentWeatherData = presenter.currentWeather else { return }
        presenter.currentWeatherModel = CurrentWeatherModel(currentWeatherData: currentWeatherData)
        guard let currentWeatherModel = presenter.currentWeatherModel else { return }
        weatherIcon.image = UIImage(systemName: currentWeatherModel.conditionName)
        locationLabel.text = currentWeatherModel.locationName
        temperatureLabel.text = currentWeatherModel.temperatureString
        weatherInfoLabel.text = currentWeatherModel.weatherName
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
