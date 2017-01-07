 //
//  WeatherModel.swift
//  WeatherMan
//
//  Created by kamous on 16/6/19.
//  Copyright © 2016年 kamous. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import CoreLocation

struct WeatherModel {
    
    static var shareInstance :WeatherModel = WeatherModel()
    
    var weatherRealTime :WeatherRealTime?
    
    private init(){}
    
    mutating func loadData(latitude: Double, longitude: Double, completion:((Bool,WeatherRealTime?) -> Void)){
        var urlStr = "https://api.caiyunapp.com/v2/\(CYToken)/\(longitude),\(latitude)/realtime.json"
        urlStr = urlStr.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        WMNetwork.shareManager.request(Alamofire.Method.GET, urlStr) { (response:WMResponseProtocol) in
            var weather: WeatherRealTime? = nil
            if response.isSuccess{
                let result = Mapper<WeatherRealTimeResult>().map(response.data)
                weather = result?.result
//                WeatherModel.shareInstance.weatherRealTime = result?.result
            }else{
                print("Failed:\(response.data)")
            }
            completion(response.isSuccess, weather)
        }
    }
    
}