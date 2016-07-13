//
//  CityManager.swift
//  WeatherMan
//
//  Created by kamous on 16/7/9.
//  Copyright © 2016年 kamous. All rights reserved.
//

import UIKit
import CoreLocation
import ObjectMapper

let kCityManagerCurCity = "curCity"

class CityManager: NSObject {
    static let shareManager: CityManager = CityManager()
    var cityList:[CityInfo]?
    private var curCity:CityInfo?
//    {
//        get{
//            if curCity == nil {
//                let dic = NSUserDefaults.standardUserDefaults().objectForKey(kCityManagerCurCity) as? [String:AnyObject]
//                let city = Mapper<CityInfo>().map(dic)
//                return city
//            }
//            return curCity
//        }
//        
//        set{
//            
//        }
//    }
    func getCurCity() -> CityInfo?{
        if curCity != nil {
            return curCity
        }else{
            let dic = NSUserDefaults.standardUserDefaults().objectForKey(kCityManagerCurCity) as? [String:AnyObject]
            let city = Mapper<CityInfo>().map(dic)
            if city != nil{
          	 return city
            }
        }
        
        curCity = CityManager.shareManager.loadCityInfo()
    	return curCity
    }
    
    func saveCurCity(cityInfo: CityInfo?){
        if let city = cityInfo{
            self.curCity = cityInfo
            
            let dic = city.toJSON()
            NSUserDefaults.standardUserDefaults().setObject(dic, forKey: kCityManagerCurCity)
        }
        
        
    }
    
    private override init(){
        cityList = NSUserDefaults.standardUserDefaults().objectForKey("CityList") as? [CityInfo]
        
    }
    
    func loadCityInfo() -> CityInfo{
        var loc = LocationManager.shareManager.location
        if (loc == nil) {
            loc = LocationManager.shareManager.lastLocation()
            if (loc == nil){
                loc = CLLocation(latitude:25.1552 ,longitude:121.6544)
            }
        }
        
        var city = CityInfo()
        city.location = LocationInfo(location: loc)
//        let dic = city.toJSON()
//        NSKeyedArchiver.archivedDataWithRootObject(<#T##rootObject: AnyObject##AnyObject#>)
//        NSUserDefaults.standardUserDefaults().setObject(dic, forKey: kCityManagerCurCity)
        
        return city
        
        
    }
    
    
}
