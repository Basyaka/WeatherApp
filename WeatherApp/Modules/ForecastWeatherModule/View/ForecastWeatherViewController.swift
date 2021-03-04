//
//  ForecastWeatherViewController.swift
//  WeatherApp
//
//  Created by Vlad Novik on 1.03.21.
//

import UIKit

class ForecastWeatherViewController: UIViewController {
    
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
        refreshControl.addTarget(self, action: #selector(updateAction), for: .valueChanged)
        return refreshControl
    }()
    
    var presenter: ForecastWeatherViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Forecast"
        setLayout()
        presenter.startUpdateLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.showForecastWeather()
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
    
    @objc func updateAction() {
        presenter.startUpdateLocation()
        presenter.showForecastWeather()
    }
}

extension ForecastWeatherViewController: WeatherViewProtocol {
    func success() {
        refresher.endRefreshing()
        guard let forecastWeatherData = presenter.forecastWeather else { return }
        presenter.forecastWeatherModel = ForecastWeatherModel(forecastWeatherData: forecastWeatherData)
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        DispatchQueue.main.async {
            self.refresher.endRefreshing()
            self.showErrorAlert(title: "Failed To Update Data" , message: "Please, check your internet connection or try requesting later.")
        }
    }
}

extension ForecastWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.forecastWeatherModel?.forecastList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier, for: indexPath) as! ForecastTableViewCell
        if let currentWeatherModel = presenter.forecastWeatherModel {
            cell.temperatureLabel.text = currentWeatherModel.temperatureArray[indexPath.row]
            cell.weatherImageView.image = UIImage(systemName: currentWeatherModel.conditionNameArray[indexPath.row])
            cell.weatherName.text = currentWeatherModel.weatherNameArray[indexPath.row]
            cell.timeLabel.text = currentWeatherModel.timeArray[indexPath.row]
        }
        return cell
    }
}
