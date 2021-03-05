//
//  WeatherInfoCollectionViewCell.swift
//  WeatherApp
//
//  Created by Vlad Novik on 3.03.21.
//

import UIKit

class WeatherInfoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "WeatherInfoCollectionViewCell"
    
    var weatherInfoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var weatherInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        let stack = UIStackView(arrangedSubviews: [weatherInfoImageView, weatherInfoLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            weatherInfoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            weatherInfoLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}


