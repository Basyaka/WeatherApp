//
//  WeatherLabel.swift
//  WeatherApp
//
//  Created by Vlad Novik on 2.03.21.
//

import UIKit

class WeatherInfoLabel: UILabel {

    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .center
        self.text = "Minsk, BY"
        self.textColor = .darkGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
