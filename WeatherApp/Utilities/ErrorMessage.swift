//
//  ErrorMessage.swift
//  WeatherApp
//
//  Created by Vlad Novik on 27.02.21.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidData = "Sorry. Somthing went wrong, try again!"
    case invalidResponce = "Server error"
}
