//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by andres on 3/17/19.
//  Copyright © 2019 tinkin. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var forecastDescriptionText: UILabel!
    @IBOutlet weak var forecastIconImageView: UIImageView!
    
    func initFromWeatherForecast(weatherForecast: WeatherForecast) {

        let dateText = weatherForecast.dateText!
        let temperature = String(format: "%.0f °C", weatherForecast.temperature! - 273.15)
        let description = weatherForecast.description!
        let fullDescription = "\(dateText) \(temperature) \(description)"
        forecastDescriptionText.text = fullDescription
        
        let networking = Networking()
        networking.getWeatherIcon(weatherIcon: weatherForecast.iconId!) { (icon) in
            self.forecastIconImageView.image = icon
        }
    }
    
}
