//
//  WeatherInfoCell.swift
//  WeatherMan
//
//  Created by kamous on 16/5/21.
//  Copyright © 2016年 kamous. All rights reserved.
//

import UIKit

class WeatherInfoCell: UITableViewCell {
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindWithWeatherData(weatherData:WeatherData?){
        if let weather = weatherData{
            self.temperatureLabel.text = weather.temperature
            self.weatherLabel.text = weather.weather
            self.infoLabel.text = weather.wind
        }
    }
    
    func bindWithWeatherRealTime(weatherData:WeatherRealTime?){
        if let weather = weatherData{
            self.temperatureLabel.text = String(format:"%.1f°",weather.temperature!)
            self.weatherLabel.text = "\(weather.skyconStr)"
            self.infoLabel.text = String(format:"PM25:%.0f",weather.pm25!)
        }
    }

}
