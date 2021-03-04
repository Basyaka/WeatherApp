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
        label.font = UIFont(name: label.font.fontName, size: (view.frame.size.height)/25)
        return label
    }()
    
    private lazy var temperatureAndWeatherNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.font = UIFont(name: label.font.fontName, size: (view.frame.size.height)/18)
        return label
    }()
    
    private lazy var weatherInfoCollectionView: UICollectionView = {
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        // Group
        let firstLvlgroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(2/5)),
            subitem: item,
            count: 3
        )
        
        let secondLvlGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(2/5)),
            subitem: item,
            count: 2
        )
        secondLvlGroup.contentInsets = .init(top: 0, leading: 50, bottom: 0, trailing: 50)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            ),
            subitems: [firstLvlgroup, secondLvlGroup]
        )
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: CurrentWeatherViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        configureController()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        startSpinner()
        presenter.showCurrentWeather()
    }
    
    private func configureController() {
        navigationItem.title = "Today"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(updateTapped))
        view.backgroundColor = .systemBackground
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
    
    @objc func updateTapped() {
        startSpinner()
        presenter.startUpdatingLocation()
        presenter.showCurrentWeather()
    }
    
    @objc private func buttonTapped() {
        if var currentWeatherModel = presenter.currentWeatherModel {
            let shareController = UIActivityViewController(activityItems: [currentWeatherModel.weatherMessage], applicationActivities: nil)
            present(shareController, animated: true, completion: nil)
        } else {
            showErrorAlert(title: "Not Found", message: "Information does not exist. Refresh the weather data.")
        }
    }
}

//MARK: - WeatherViewProtocol
extension CurrentWeatherViewController: WeatherViewProtocol {    
    func success() {
        stopSpinner()
        guard let currentWeatherData = presenter.currentWeather else { return }
        presenter.currentWeatherModel = CurrentWeatherModel(currentWeatherData: currentWeatherData)
        guard let currentWeatherModel = presenter.currentWeatherModel else { return }
        weatherIcon.image = UIImage(systemName: currentWeatherModel.conditionName)
        locationLabel.text = currentWeatherModel.locationName
        temperatureAndWeatherNameLabel.text = currentWeatherModel.temperatureAndWeatherNameString
        weatherInfoCollectionView.reloadData()
    }
    
    func failure(error: Error) {
        DispatchQueue.main.async {
            self.stopSpinner()
            self.showErrorAlert(title: "Failed To Update Data" , message: "Please, check your internet connection or try requesting later.")
        }
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


