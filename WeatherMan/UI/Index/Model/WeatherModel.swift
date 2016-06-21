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

struct WeatherModel {
    
    static var shareInstance :WeatherModel = WeatherModel()
    
    var weatherRealTime :WeatherRealTime?
    
    private init(){}
    
    mutating func loadData(completion:(Bool -> Void)){
        var urlStr = "https://api.caiyunapp.com/v2/\(CYToken)/121.6544,25.1552/realtime.json"
        urlStr = urlStr.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        WMNetwork.shareManager.request(Alamofire.Method.GET, urlStr) { (response:WMResponseProtocol) in
            if response.isSuccess{
                let result = Mapper<WeatherRealTimeResult>().map(response.data)
                WeatherModel.shareInstance.weatherRealTime = result?.result
//                self.saveDataSource()
                //                print("Success:\(response.data)")
            }else{
                print("Failed:\(response.data)")
            }
//            if (completion){
                completion(response.isSuccess)
//            }
        }
    }
    
}