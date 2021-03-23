//
//  CurrentWeatherViewController.swift
//  WeatherApp
//
//  Created by Vlad Novik on 27.02.21.
//

import UIKit
import CoreLocation

class CurrentWeatherViewController: UIViewController {
    
    var presenter: CurrentWeatherViewPresenterProtocol!

    //UI elements
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
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: label.font.fontName, size: (view.frame.size.height)/25)
        return label
    }()
    
    private lazy var temperatureAndWeatherNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: label.font.fontName, size: (view.frame.size.height)/18)
        return label
    }()
    
    private lazy var weatherInfoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: WeatherInfoCollectionViewLayout.createCompositionalLayout())
        collectionView.register(WeatherInfoCollectionViewCell.self, forCellWithReuseIdentifier: WeatherInfoCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.setTitle("Share", for: .normal)
        button.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        startSpinner()
        presenter.startUpdatingLocation()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //Method to start configure VC
    private func configureController() {
        navigationItem.title = "Today"
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(updateTapped))
        
        setLayout()
        
       NotificationCenter.default.addObserver(self, selector: #selector(updateCurrentWeather), name: .changeCurrentLocation, object: nil)
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
        
        let mainInfoStack = UIStackView(arrangedSubviews: [stackForImageIconAndLocation, temperatureAndWeatherNameLabel])
        mainInfoStack.translatesAutoresizingMaskIntoConstraints = false
        mainInfoStack.axis = .vertical
        
        view.addSubview(mainInfoStack)
        NSLayoutConstraint.activate([
            stackForImageIconAndLocation.heightAnchor.constraint(equalTo: mainInfoStack.heightAnchor, multiplier: 0.73),
            temperatureAndWeatherNameLabel.heightAnchor.constraint(equalTo: mainInfoStack.heightAnchor, multiplier: 0.27),
            
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
            shareButton.heightAnchor.constraint(equalToConstant: 50
            ),
            shareButton.widthAnchor.constraint(equalToConstant: 100),
            shareButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

//MARK: - Actions
extension CurrentWeatherViewController {
    @objc func updateTapped() {
        startSpinner()
        presenter.startUpdatingLocation()
    }
    
    @objc private func shareTapped() {
        if var currentWeatherModel = presenter.currentWeatherModel {
            let shareController = UIActivityViewController(activityItems: [currentWeatherModel.weatherMessage], applicationActivities: nil)
            present(shareController, animated: true, completion: nil)
        } else {
            showErrorAlert(title: ErrorMessage.ShareError.titleShareError, message: ErrorMessage.ShareError.bodyShareError)
        }
    }
    
    @objc private func updateCurrentWeather() {
        presenter.showCurrentWeather()
    }
}

//MARK: - WeatherViewProtocol
extension CurrentWeatherViewController: WeatherViewProtocol {    
    func success() {
        stopSpinner()
        guard let currentWeatherModel = presenter.currentWeatherModel else { return }
        self.weatherIcon.image = UIImage(systemName: currentWeatherModel.conditionName)
        self.locationLabel.text = currentWeatherModel.locationName
        self.temperatureAndWeatherNameLabel.text = currentWeatherModel.temperatureAndWeatherNameString
        self.weatherInfoCollectionView.reloadData()
    }
    
    func failure(error: Error) {
        guard let currentWeatherModel = presenter.currentWeatherStorageModel else { return }
        DispatchQueue.main.async {
            self.showErrorAlert(title: ErrorMessage.NetError.titleNetError , message: ErrorMessage.NetError.bodyNetError)
            self.weatherIcon.image = UIImage(systemName: currentWeatherModel.conditionName!)
            self.locationLabel.text = currentWeatherModel.locationName
            self.temperatureAndWeatherNameLabel.text = currentWeatherModel.temperatureAndWeatherNameString
            self.weatherInfoCollectionView.reloadData()
            self.stopSpinner()
        }
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CurrentWeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let currentWeatherModel = presenter.currentWeatherModel?.collectionInfoArray {
            return currentWeatherModel.count
        } else if let currentWeatherModel = presenter.currentWeatherStorageModel?.collectionInfoArray {
            return currentWeatherModel.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherInfoCollectionViewCell.identifier, for: indexPath) as! WeatherInfoCollectionViewCell
        cell.weatherInfoImageView.image = UIImage(systemName: K.collectionImageStringArray[indexPath.item])
        if var currentWeatherModel = presenter.currentWeatherModel {
            cell.weatherInfoLabel.text = currentWeatherModel.collectionInfoArray[indexPath.item]
        } else if var currentWeatherModel = presenter.currentWeatherStorageModel {
            cell.weatherInfoLabel.text = currentWeatherModel.collectionInfoArray[indexPath.item]
        }
        return cell
    }
}


