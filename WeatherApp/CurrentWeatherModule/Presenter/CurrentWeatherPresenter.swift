//
//  CurrentWeatherPresenter.swift
//  WeatherApp
//
//  Created by Vlad Novik on 27.02.21.
//

import Foundation

protocol CurrentWeatherViewProtocol: class {
    func success() //данные пришли
    func failure(error: Error) //данные не пришли
}

protocol CurrentWeatherViewPresenterProtocol: class {
    init(view: CurrentWeatherViewProtocol, networkService: NetworkServiceProtocol)
    func showCurrentWeather() //запрашивает погоду из сети
    var currentWeather: Person? { get set } //погода, которая пришла
}

class CurrentWeatherPresenter: CurrentWeatherViewPresenterProtocol {
    weak var view: CurrentWeatherViewProtocol?
    let networkService: NetworkServiceProtocol!
    var currentWeather: Person?
    
    
    required init(view: CurrentWeatherViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        //когда из вне будет пуш, вызовется show
        showCurrentWeather()
    }
    
    func showCurrentWeather() {
        networkService.request(router: Router.getCurrentWeather) { (result: Result<Person, Error>) in
            switch result {
            case .success(let currentWeather):
                self.currentWeather = currentWeather
                self.view?.success()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
}


