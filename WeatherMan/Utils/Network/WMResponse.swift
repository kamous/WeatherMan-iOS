//
//  Response.swift
//  WeatherMan
//
//  Created by kamous on 16/4/27.
//  Copyright © 2016年 kamous. All rights reserved.
//

import Foundation

import ObjectMapper

public struct WMResponse: Mappable {
    var isSuccess:Bool = false
    var msg:String?
    var code:Int?
    var data:AnyObject?
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