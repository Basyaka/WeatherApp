//
//  CDCurrentWeather+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Vlad Novik on 5.03.21.
//
//

import Foundation
import CoreData


extension CDCurrentWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCurrentWeather> {
        return NSFetchRequest<CDCurrentWeather>(entityName: "CDCurrentWeather")
    }

    @NSManaged public var amountOfRainString: String?
    @NSManaged public var conditionName: String?
    @NSManaged public var humidityString: String?
    @NSManaged public var locationName: String?
    @NSManaged public var pressureString: String?
    @NSManaged public var temperatureAndWeatherNameString: String?
    @NSManaged public var windDirection: String?
    @NSManaged public var windSpeedString: String?

}

extension CDCurrentWeather : Identifiable {

}
