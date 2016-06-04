//
//  CityWetaherInfoCell.swift
//  WeatherMan
//
//  Created by kamous on 16/5/22.
//  Copyright © 2016年 kamous. All rights reserved.
//

import UIKit

class CityWetaherInfoCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clearColor()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindWithCityData(cityData:CityData?){
        self.cityLabel.text = cityData?.currentCity
        
        let weather = cityData?.weatherDatas?[0]
        
        self.temperatureLabel.text = weather?.temperature
        self.subLabel.text = weather?.weather
    }

}
