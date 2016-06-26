//
//  CityNameCell.swift
//  WeatherMan
//
//  Created by kamous on 16/6/25.
//  Copyright © 2016年 kamous. All rights reserved.
//

import UIKit
import CoreLocation

class CityNameCell: UITableViewCell {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var subInfoLabel: UILabel!
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clearColor()
    }
    
    func bindWithPlacemark(placemark:CLPlacemark?){
        if let place = placemark{
            var city = place.name
            if city == nil {
                city = place.locality
            }
            if city == nil {
                city = place.administrativeArea
            }
            
            let street = place.thoroughfare
            self.infoLabel.text = city
            self.subInfoLabel.text = street
            
        }
    }
}
