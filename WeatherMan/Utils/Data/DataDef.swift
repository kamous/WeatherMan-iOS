//
//  Data.swift
//  WeatherMan
//
//  Created by kamous on 16/5/9.
//  Copyright © 2016年 kamous. All rights reserved.
//

import Foundation
import ObjectMapper

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