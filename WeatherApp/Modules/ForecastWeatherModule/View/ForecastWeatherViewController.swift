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
        return tb
    }()
    
    var presenter: ForecastWeatherViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
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

extension ForecastWeatherViewController: WeatherViewProtocol {
    func success() {
        guard let forecastWeatherData = presenter.forecastWeather else { return }
        presenter.forecastWeatherModel = ForecastWeatherModel(forecastWeatherData: forecastWeatherData)
        guard let currentWeatherModel = presenter.forecastWeatherModel else { return }
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

extension ForecastWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier, for: indexPath)
        return cell
    }
}
