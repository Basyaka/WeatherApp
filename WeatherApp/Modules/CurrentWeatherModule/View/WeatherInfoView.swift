//
//  WeatherInfoView.swift
//  WeatherApp
//
//  Created by Vlad Novik on 2.03.21.
//

import UIKit

class WeatherInfoView: UIView {
    init(imageName: String, label: WeatherInfoLabel) {
        
        super.init(frame: .zero)
        let imageView = UIImageView(image: UIImage(systemName: imageName))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .vertical
    
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
