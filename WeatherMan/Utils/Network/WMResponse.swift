//
//  Response.swift
//  WeatherMan
//
//  Created by kamous on 16/4/27.
//  Copyright © 2016年 kamous. All rights reserved.
//

import Foundation

import ObjectMapper
public protocol WMResponseProtocol:Mappable {
    var isSuccess:Bool{get set}
    var msg:String?{get set}
    var code:Int?{get set}
    var data:AnyObject?{get set}
}

public struct WMResponse: Mappable,WMResponseProtocol{
    public var isSuccess:Bool = false
    public var msg:String?
    public var code:Int?
    public var data:AnyObject?
    public init?(_ map:Map){
        
    }
    
    init(isSuccess: Bool, msg: String?, code :Int?, data: AnyObject?){
        
        self.isSuccess = isSuccess
        self.msg = msg
        self.code = code
        self.data = data
    }
    
    public mutating func mapping(map: Map) {
        isSuccess		<- map["successful"]
        msg				<- map["error"]
        code			<- map["code"]
        data			<- map["data"]
    }
}


public struct WMWeatherResponse: WMResponseProtocol,Mappable {
    public var isSuccess:Bool = false
    public var msg:String?
    public var code:Int?
    public var data:AnyObject?
    
    var status:String? {
        willSet(newStatus){
            if newStatus == "success" {
                isSuccess = true
            }
        }
    }
    var results:AnyObject?{
        willSet(newResults){
            if let result = newResults {
                data = ["results":result]
            }
            
        }
    }
    
    public init?(_ map:Map){
        
    }
    
//    init(isSuccess: Bool, msg: String?, code :Int?, data: AnyObject?){
//        
//        self.isSuccess = isSuccess
//        self.msg = msg
//        self.code = code
//        self.data = data
//    }
    
    public mutating func mapping(map: Map) {
        isSuccess		<- map["successful"]
        msg				<- map["error"]
        code			<- map["error"]
        data			<- map["data"]
        status			<- map["status"]
        results			<- map["results"]
    }
}