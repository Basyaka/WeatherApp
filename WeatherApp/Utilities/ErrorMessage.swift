//
//  ErrorMessage.swift
//  WeatherApp
//
//  Created by Vlad Novik on 5.03.21.
//

import Foundation

struct ErrorMessage {
    struct NetError {
        static let titleNetError = "Failed To Update Data"
        static let bodyNetError = "Please, check your internet connection and try requesting later. \n Downloaded data from the archive."
    }
    
    struct ShareError {
        static let titleShareError = "No New Information Found"
        static let bodyShareError = "Information does not exist. Refresh the weather data."
    }
    
}
