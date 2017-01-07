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
let kCityManagerCityList = "cityList"
let kCityManagerCurCityIndex = "curCityIndex"

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
    
    
    private override init(){
        super.init()
        let dic = NSUserDefaults.standardUserDefaults().objectForKey(kCityManagerCityList)
        self.cityList = Mapper<CityInfo>().mapArray(dic)
        
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
    
    func saveCityList(cityList: [CityInfo]?){
        self.cityList = cityList
        if let cities = cityList{
            
            let dic = cities.toJSON()
            NSUserDefaults.standardUserDefaults().setObject(dic, forKey: kCityManagerCityList)
        }
        
        
    }
    
    func getCurCityIndex() -> Int{
        if let index = ((NSUserDefaults.standardUserDefaults().objectForKey(kCityManagerCurCityIndex)) as? NSNumber)?.integerValue{
            return index
        }
        return 0
    }
    
    func saveCurCityIndex(index: Int){
        NSUserDefaults.standardUserDefaults().setObject(NSNumber.init(long: index), forKey: kCityManagerCurCityIndex)
    }

    
    
}
