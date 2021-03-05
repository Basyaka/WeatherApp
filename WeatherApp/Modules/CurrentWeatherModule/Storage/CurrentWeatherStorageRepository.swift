//
//  CurrentWeatherStorageRepository.swift
//  WeatherApp
//
//  Created by Vlad Novik on 5.03.21.
//

import Foundation
import CoreData

class CurrentWeatherStorageRepository {
    
    func create(currentWeather: CurrentWeatherModel) {
        let cdCurrentWeather = CDCurrentWeather(context: PersistentStorage.shared.context)
        cdCurrentWeather.conditionName = currentWeather.conditionName
        cdCurrentWeather.amountOfRainString = currentWeather.amountOfRainString
        cdCurrentWeather.humidityString = currentWeather.humidityString
        cdCurrentWeather.locationName = currentWeather.locationName
        cdCurrentWeather.pressureString = currentWeather.pressureString
        cdCurrentWeather.temperatureAndWeatherNameString = currentWeather.temperatureAndWeatherNameString
        cdCurrentWeather.windDirection = currentWeather.windDirection
        cdCurrentWeather.windSpeedString = currentWeather.windSpeedString
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [CurrentWeatherStorageModel]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDCurrentWeather.self)
        
        var weatherStorageArray: [CurrentWeatherStorageModel] = []
        
        result?.forEach({ (cdCurrentWeather) in
            let currendWeather = CurrentWeatherStorageModel(conditionName: cdCurrentWeather.conditionName,
                                                            windDirection: cdCurrentWeather.windDirection,
                                                            temperatureAndWeatherNameString: cdCurrentWeather.temperatureAndWeatherNameString,
                                                            pressureString: cdCurrentWeather.pressureString,
                                                            windSpeedString: cdCurrentWeather.windSpeedString,
                                                            humidityString: cdCurrentWeather.humidityString,
                                                            locationName: cdCurrentWeather.locationName,
                                                            amountOfRainString: cdCurrentWeather.amountOfRainString)
            weatherStorageArray.append(currendWeather)
        })
        return weatherStorageArray
    }
    
    func delete() {
        guard let cdCurrentWeather = getElement() else { return }
        PersistentStorage.shared.context.delete(cdCurrentWeather)
        PersistentStorage.shared.saveContext()
    }
    
    private func getElement() -> CDCurrentWeather? {
        let fetchRequest = NSFetchRequest<CDCurrentWeather>(entityName: "CDCurrentWeather")
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else {return nil}
            return result
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
}
