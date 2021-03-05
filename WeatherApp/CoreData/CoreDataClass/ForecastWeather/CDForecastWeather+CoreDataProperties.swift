//
//  CDForecastWeather+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Vlad Novik on 5.03.21.
//
//

import Foundation
import CoreData


extension CDForecastWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDForecastWeather> {
        return NSFetchRequest<CDForecastWeather>(entityName: "CDForecastWeather")
    }

    @NSManaged public var timeArray: [String]?
    @NSManaged public var weatherNameArray: [String]?
    @NSManaged public var conditionNameArray: [String]?
    @NSManaged public var temperatureArray: [String]?

}

extension CDForecastWeather : Identifiable {

}
