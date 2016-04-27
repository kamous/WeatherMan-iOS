//
//  IndicatorView.swift
//  WeatherMan
//
//  Created by kamous on 16/4/27.
//  Copyright © 2016年 kamous. All rights reserved.
//

import Foundation
import PKHUD

public struct IndicatorView{
    public static func showString(msg: String){
        HUD.flash(.Label(msg), delay: 1)
    }
}