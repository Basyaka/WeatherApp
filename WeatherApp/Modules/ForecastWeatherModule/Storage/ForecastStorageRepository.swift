//
//  ForecastStorageRepository.swift
//  WeatherApp
//
//  Created by Vlad Novik on 5.03.21.
//

import Foundation
import CoreData

class ForecastStorageRepository {
    
    func create(forecastWeather: ForecastWeatherModel) {
        let cdForecastWeather = CDForecastWeather(context: PersistentStorage.shared.context)
        cdForecastWeather.conditionNameArray = forecastWeather.conditionNameArray
        cdForecastWeather.temperatureArray = forecastWeather.temperatureArray
        cdForecastWeather.timeArray = forecastWeather.timeArray
        cdForecastWeather.weatherNameArray = forecastWeather.weatherNameArray
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [ForecastWeatherStorageModel]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDForecastWeather.self)
        
        var foreastStorageArray: [ForecastWeatherStorageModel] = []
        
        result?.forEach({ (cdForecastWeather) in
            let forecastWeather = ForecastWeatherStorageModel(timeArray: cdForecastWeather.timeArray,
                                                              weatherNameArray: cdForecastWeather.weatherNameArray,
                                                              conditionNameArray: cdForecastWeather.conditionNameArray,
                                                              temperatureArray: cdForecastWeather.temperatureArray)
            foreastStorageArray.append(forecastWeather)
        })
        return foreastStorageArray
    }
    
    func delete() {
        guard let CDForecastWeather = getElement() else { return }
        PersistentStorage.shared.context.delete(CDForecastWeather)
        PersistentStorage.shared.saveContext()
    }
    
    private func getElement() -> CDForecastWeather? {
        let fetchRequest = NSFetchRequest<CDForecastWeather>(entityName: "CDForecastWeather")
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else {return nil}
            return result
        } catch let error {
            print(error)
        }
        return nil
    }
}
