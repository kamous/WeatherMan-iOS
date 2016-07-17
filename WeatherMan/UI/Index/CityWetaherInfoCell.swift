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
    @IBOutlet weak var selectedView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clearColor()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindWithCityInfo(cityInfo:CityInfo?, isSelected: Bool){
        self.cityLabel.text = cityInfo?.name
        self.selectedView.hidden = !isSelected
//        let weather = cityInfo?.weatherDatas?[0]
        if let weather =  cityInfo?.weather{
            self.temperatureLabel.text = String(format:"%.1f°",weather.temperature!)
            self.subLabel.text = "\(weather.skyconStr)"
        }else{
            self.temperatureLabel.text = "--"
            self.subLabel.text = ""
        }
        
    }

}
