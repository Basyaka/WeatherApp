//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Vlad Novik on 3.03.21.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    static let identifier = "ForecastTableViewCell"
    
    var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var timeLabel = UILabel()
    var weatherName = UILabel()
    
    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemBlue
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        startSettings()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startSettings() {
        selectionStyle = .none
        temperatureLabel.font = UIFont(name: temperatureLabel.font.fontName, size: (contentView.frame.size.width)/6)
        timeLabel.adjustsFontSizeToFitWidth = true
        weatherName.adjustsFontSizeToFitWidth = true
    }
    
    func setLayout() {
        let stack = UIStackView(arrangedSubviews: [timeLabel, weatherName])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        
        addSubview(weatherImageView)
        addSubview(temperatureLabel)
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            weatherImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            weatherImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1/4.5),
            weatherImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/4.5),
            
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            temperatureLabel.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1/4),
            temperatureLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/4),
            
            stack.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor, constant: -10),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
