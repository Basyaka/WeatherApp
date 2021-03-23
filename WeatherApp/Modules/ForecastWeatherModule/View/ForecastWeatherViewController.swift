//
//  ForecastWeatherViewController.swift
//  WeatherApp
//
//  Created by Vlad Novik on 1.03.21.
//

import UIKit

class ForecastWeatherViewController: UIViewController {
    
    var presenter: ForecastWeatherViewPresenterProtocol!
    
    private lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.delegate = self
        tb.dataSource = self
        tb.register(ForecastTableViewCell.self, forCellReuseIdentifier: ForecastTableViewCell.identifier)
        tb.rowHeight = 100
        tb.refreshControl = refresher
        return tb
    }()
    
    private lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(updateWeatherTapped), for: .valueChanged)
        return refreshControl
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
    
    //Methods to start configure VC
    private func configureController() {
        navigationItem.title = "Forecast"
        
        setLayout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateCurrentWeather), name: .changeCurrentLocation, object: nil)
    }
    
    private func setLayout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - Actions
extension ForecastWeatherViewController {
    @objc func updateWeatherTapped() {
        presenter.startUpdatingLocation()
    }
    
    @objc private func updateCurrentWeather() {
        presenter.showForecastWeather()
    }
}

//MARK: - WeatherViewProtocol
extension ForecastWeatherViewController: WeatherViewProtocol {
    func success() {
        refresher.endRefreshing()
        self.stopSpinner()
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        DispatchQueue.main.async {
            self.refresher.endRefreshing()
            self.stopSpinner()
            self.showErrorAlert(title: ErrorMessage.NetError.titleNetError, message: ErrorMessage.NetError.bodyNetError)
            self.tableView.reloadData()
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ForecastWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let forecastWeatherModel = presenter.forecastWeatherModel?.forecastList {
            return forecastWeatherModel.count
        } else if let forecastWeatherStorageModel = presenter.forecastWeatherStorageModel?.conditionNameArray {
            return forecastWeatherStorageModel.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier, for: indexPath) as! ForecastTableViewCell
        if let forecastWeatherModel = presenter.forecastWeatherModel {
            cell.temperatureLabel.text = forecastWeatherModel.temperatureArray[indexPath.row]
            cell.weatherImageView.image = UIImage(systemName: forecastWeatherModel.conditionNameArray[indexPath.row])
            cell.weatherName.text = forecastWeatherModel.weatherNameArray[indexPath.row]
            cell.timeLabel.text = forecastWeatherModel.timeArray[indexPath.row]
        } else if let forecastWeatherStorageModel = presenter.forecastWeatherStorageModel {
            cell.temperatureLabel.text = forecastWeatherStorageModel.temperatureArray?[indexPath.row]
            cell.weatherImageView.image = UIImage(systemName: (forecastWeatherStorageModel.conditionNameArray?[indexPath.row])!)
            cell.weatherName.text = forecastWeatherStorageModel.weatherNameArray?[indexPath.row]
            cell.timeLabel.text = forecastWeatherStorageModel.timeArray?[indexPath.row]
        }
        return cell
    }
}
