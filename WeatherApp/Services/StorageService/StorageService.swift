//
//  StorageService.swift
//  WeatherApp
//
//  Created by Vlad Novik on 5.03.21.
//

import Foundation

protocol StorageServiceProtocol {
    func createCurrentWeatherStorageObject(currentWeather: CurrentWeatherModel)
    func getAllCurrentWeatherStorageModel() -> [CurrentWeatherStorageModel]?
    func deleteCurrentWeatherStorageObject()
    func createForecastWeatherStorageObject(forecastWeather: ForecastWeatherModel)
    func getAllForecastWeatherStorageModel() -> [ForecastWeatherStorageModel]?
    func deleteForecastWeatherStorageObject()
}

class StorageService: StorageServiceProtocol {
    private let currentWeatherRepository = CurrentWeatherStorageRepository()
    private let forecastRepository = ForecastStorageRepository()
    
    func createCurrentWeatherStorageObject(currentWeather: CurrentWeatherModel) {
        return currentWeatherRepository.create(currentWeather: currentWeather)
    }
    
    func getAllCurrentWeatherStorageModel() -> [CurrentWeatherStorageModel]? {
        return currentWeatherRepository.getAll()
    }
    
    func deleteCurrentWeatherStorageObject() {
        return currentWeatherRepository.delete()
    }
    
    func createForecastWeatherStorageObject(forecastWeather: ForecastWeatherModel) {
        return forecastRepository.create(forecastWeather: forecastWeather)
    }
    
    func getAllForecastWeatherStorageModel() -> [ForecastWeatherStorageModel]? {
        return forecastRepository.getAll()
    }
    
    func deleteForecastWeatherStorageObject() {
        return forecastRepository.delete()
    }
}
