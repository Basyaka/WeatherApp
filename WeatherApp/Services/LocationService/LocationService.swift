//
//  LocationService.swift
//  WeatherApp
//
//  Created by Vlad Novik on 1.03.21.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol: class {
    func getCurrentLocation() -> Location?
    func startUpdatingLocation()
}

class LocationService: NSObject, CLLocationManagerDelegate, LocationServiceProtocol {

    private let locationManager = CLLocationManager()
    private var currentLocation: Location?
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            currentLocation = Location(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            print("Loc in didUpdateLoc \(currentLocation)")
        }
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func getCurrentLocation() -> Location? {
        guard let location = currentLocation else { return nil }
        return location
    }
}
