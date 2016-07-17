//
//  Data.swift
//  WeatherMan
//
//  Created by kamous on 16/5/9.
//  Copyright © 2016年 kamous. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreLocation

//MARK:- Baidu
struct WeatherData: Mappable{
    var date: String?
    var dayPictureUrl: String?
    var nightPictureUrl :String?
    var weather: String?
    var wind: String?
    var temperature :String?
    
    var weatherDatas:[WeatherData]?
    init?(_ map:Map){
        
    }
    
    mutating func mapping(map: Map){
        date		<- map["date"]
        dayPictureUrl			<- map["dayPictureUrl"]
        nightPictureUrl	<- map["nightPictureUrl"]
        weather		<- map["weather"]
        wind			<- map["wind"]
        temperature	<- map["temperature"]
    }
}
struct CityData:Mappable {
    var currentCity: String?
    var pm25: String?
    var weatherDatas:[WeatherData]?
    
    init?(_ map:Map){
        
    }
    
    
    mutating func mapping(map: Map) {
        currentCity		<- map["currentCity"]
        pm25			<- map["pm25"]
        weatherDatas	<- map["weather_data"]
    }
}

struct WeatherResult:Mappable{
    var date: String?
    var results:[CityData]?
    
    init?(_ map:Map){
        
    }
    
    
    mutating func mapping(map: Map) {
        date		<- map["date"]
        results		<- map["results"]
    }
}


//MARK: - 彩云
//天气状况
enum Skycon :String{
    case ClearDay          = "CLEAR_DAY"//晴天
    case ClearNight        = "CLEAR_NIGHT"//晴夜
    case PartlyCloudyDay   = "PARTLY_CLOUDY_DAY"//多云
    case PartlyCloudyNight = "PARTLY_CLOUDY_NIGHT"//多云
    case Cloudy            = "CLOUDY"//阴
    case Rain              = "RAIN"//雨
    case Sleet             = "SLEET"//冻雨
    case Snow              = "SNOW"//雪
    case Wind              = "WIND"//风
    case Fog               = "FOG"//雾
    case Haze              = "HAZE"//霾
}
struct WeatherRealTime: Mappable{
    var temperature: Float?
    var pm25: Float?
    var cloudrate :Float?
    var humidity :Float?
    var skycon: Skycon = .ClearDay
    var skyconStr: String{
        get{
            let str: String
            
            switch skycon {
            case .ClearDay:
                str = "晴天"
            case .ClearNight:
                str = "晴夜"
            case .PartlyCloudyDay:
                str = "多云"
            case .PartlyCloudyNight:
                str = "多云"
            case .Cloudy:
                str = "阴"
            case .Rain:
                str = "雨"
            case .Sleet:
                str = "冻雨"
            case .Snow:
                str = "雪"
            case .Wind:
                str = "风"
            case .Fog:
                str = "雾"
            case .Haze:
                str = "霾"
            default:
                str = "未知"
            }
            return str
        }
    }
    
//    var weatherDatas:[WeatherData]?
    init?(_ map:Map){
        
    }
    
    mutating func mapping(map: Map){
        temperature		<- map["temperature"]
        pm25			<- map["pm25"]
        cloudrate	<- map["cloudrate"]
        humidity		<- map["humidity"]
        skycon		<- map["skycon"]
    }
}
//"status":"ok",
//
//"precipitation":{  //降水
//    "nearest":{ //最近的降水带 //用户补充：nearest这段有时候没有
//        "status":"ok",
//        "distance":0.77, //距离
//        "intensity":0.3125 //角度
//    },
//    "local":{ //本地的降水
//        "status":"ok",
//        "intensity":0.2812, //降水强度
//        "datasource":"radar" //数据源
//    }
//},
//"wind":{ //风
//    "direction":25.33, //风向。单位是度。正北方向为0度，顺时针增加到360度。
//    "speed":83.3 //风速，米制下是公里每小时
//}



struct WeatherRealTimeResult:Mappable{
    var status: String?
    var result:WeatherRealTime?
    
    init?(_ map:Map){
        
    }
    
    
    mutating func mapping(map: Map) {
        status		<- map["status"]
        result		<- map["result"]
    }
}

//struct PlacemarkInfo:Mappable{
//    public var name: String? { get } // eg. Apple Inc.
//    public var thoroughfare: String? { get } // street name, eg. Infinite Loop
//    public var subThoroughfare: String? { get } // eg. 1
//    public var locality: String? { get } // city, eg. Cupertino
//    public var subLocality: String? { get } // neighborhood, common name, eg. Mission District
//    public var administrativeArea: String? { get } // state, eg. CA
//    public var subAdministrativeArea: String? { get } // county, eg. Santa Clara
//    public var postalCode: String? { get } // zip code, eg. 95014
//    public var ISOcountryCode: String? { get } // eg. US
//    public var country: String? { get } // eg. United States
//    public var inlandWater: String? { get } // eg. Lake Tahoe
//    public var ocean: String? { get } // eg. Pacific Ocean
//    public var areasOfInterest: [String]? { get } // eg. Golden Gate Park
//    
//    
//    init?(_ map:Map){
//        
//    }
//    
//    init(){
//        
//    }
//    mutating func mapping(map: Map) {
//        name		<- map["name"]
//        placemark	<- map["placemark"]
//        location	<- map["location"]
//        weather		<- map["weather"]
//    }
//}

struct LocationInfo:Mappable{
    var latitude: Double = 0
    var longitude: Double = 0
    
    init?(_ map:Map){
        
    }
    
    init(){
        
    }
    
    init(latitude: Double, longitude: Double){
        self.init()
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(location:CLLocation?){
        self.init()
        if let loc = location {
            self.latitude = loc.coordinate.latitude
            self.longitude = loc.coordinate.longitude
        }
        
    }
    
    mutating func mapping(map: Map) {
        latitude	<- map["latitude"]
        longitude	<- map["longitude"]
    }
}


struct Placemark:Mappable{
    var name: String?
    var thoroughfare: String?
    var locality: String?
    var administrativeArea: String?
    var location: LocationInfo?
    
    init?(_ map:Map){
        
    }
    
    init(){
        
    }
    
    init(placemark:CLPlacemark?){
        self.init()
        if let place = placemark {
            self.name = place.name
            self.thoroughfare = place.thoroughfare
            self.locality = place.locality
            self.administrativeArea = place.administrativeArea
            self.location = LocationInfo(location: place.location)
        }
        
    }
    
    mutating func mapping(map: Map) {
        name	<- map["name"]
        thoroughfare	<- map["thoroughfare"]
        locality	<- map["locality"]
        administrativeArea	<- map["thoroughfare"]
        location	<- map["location"]
    }
}

struct CityInfo:Mappable{

    var placemark: Placemark?//CLPlacemark?
    var location: LocationInfo?//CLLocation?
    var weather: WeatherRealTime?
    
    var name: String?{
        get{
			var cityName = self.placemark?.locality
            if cityName == nil {
                cityName = self.placemark?.administrativeArea
            }
            if cityName == nil {
                cityName = self.placemark?.name
            }
            return cityName
        }
            set{
                
            }
    }
    
    init?(_ map:Map){
        
    }
    
    init(){
        
    }
    mutating func mapping(map: Map) {
        name		<- map["name"]
        placemark	<- map["placemark"]
        location	<- map["location"]
        weather		<- map["weather"]
    }
}

