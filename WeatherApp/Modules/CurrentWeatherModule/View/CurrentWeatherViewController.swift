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
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont(name: label.font.fontName, size: (view.frame.size.height)/25)
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .systemBlue
        label.font = UIFont(name: label.font.fontName, size: (view.frame.size.height)/15)
        return label
    }()
    
    private lazy var weatherInfoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .systemBlue
        label.font = UIFont(name: label.font.fontName, size: (view.frame.size.height)/15)
        return label
    }()
    
    private lazy var weatherInfoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: (view.frame.size.width/4.5), height: (view.frame.size.width/4.5))
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WeatherInfoCollectionViewCell.self, forCellWithReuseIdentifier: WeatherInfoCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("Share", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: CurrentWeatherViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        tabBarController?.title = "Today" ///////////////
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
        
        view.addSubview(weatherInfoCollectionView)
        NSLayoutConstraint.activate([
            weatherInfoCollectionView.topAnchor.constraint(equalTo: mainInfoStack.bottomAnchor, constant: (view.frame.size.height)/25),
            weatherInfoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherInfoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherInfoCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherInfoCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
        
        view.addSubview(shareButton)
        NSLayoutConstraint.activate([
            shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shareButton.heightAnchor.constraint(equalToConstant: 50),
            shareButton.widthAnchor.constraint(equalToConstant: 100),
            shareButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
    }
    @objc private func buttonTapped() {
        presenter.showCurrentWeather()
    }
}

//MARK: - WeatherViewProtocol
extension CurrentWeatherViewController: WeatherViewProtocol {    
    func success() {
        guard let currentWeatherData = presenter.currentWeather else { return }
        presenter.currentWeatherModel = CurrentWeatherModel(currentWeatherData: currentWeatherData)
        guard let currentWeatherModel = presenter.currentWeatherModel else { return }
        weatherIcon.image = UIImage(systemName: currentWeatherModel.conditionName)
        locationLabel.text = currentWeatherModel.locationName
        temperatureLabel.text = currentWeatherModel.temperatureString
        weatherInfoLabel.text = currentWeatherModel.weatherName
        weatherInfoCollectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CurrentWeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.currentWeatherModel?.collectionInfoArray.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherInfoCollectionViewCell.identifier, for: indexPath) as! WeatherInfoCollectionViewCell
        if var currentWeatherModel = presenter.currentWeatherModel {
            cell.weatherInfoLabel.text = currentWeatherModel.collectionInfoArray[indexPath.item]
            cell.weatherInfoImageView.image = UIImage(systemName: currentWeatherModel.collectionImageStringArray[indexPath.item])
        }
        return cell
    }
}


