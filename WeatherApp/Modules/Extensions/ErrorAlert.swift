//
//  ErrorAlert.swift
//  WeatherApp
//
//  Created by Vlad Novik on 4.03.21.
//

import UIKit

extension UIViewController {
    //  "Failed To Update Data" "Please, check your internet connection or try requesting later."
    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
