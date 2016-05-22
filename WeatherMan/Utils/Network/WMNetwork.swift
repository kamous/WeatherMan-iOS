//
//  Network.swift
//  WeatherMan
//
//  Created by kamous on 16/4/27.
//  Copyright © 2016年 kamous. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

public struct WMNetwork {
    
    // MARK:
    static func hundleHttpHeader(var headers: [String: String]? = nil) -> [String: String]? {
        if headers == nil {
            headers = Dictionary<String, String>()
        }
        
//        //        上传图片
//        var manager = Manager.sharedInstance
//        manager.session.configuration.HTTPAdditionalHeaders = ["Content-Type:":"multipart/form-data"]
//        
//        
//        // 版本号
//        let requestValue = "platform=iphone|version=\(AppUtil.appShortVersion())";
//        headers?["X-User-Agent"] = requestValue
        
        return headers
    }
    
    // MARK:接口
    static let shareManager: WMNetwork = {
        return WMNetwork()
    }()
    
    
    public func request(method: Alamofire.Method,
                        _ URLString: URLStringConvertible,
                          parameters: [String: AnyObject]? = nil,
                          encoding: ParameterEncoding = .URL,
                          var headers: [String: String]? = nil,
                              completionHandler: WMResponseProtocol -> Void)
    {
        headers = WMNetwork.hundleHttpHeader(headers)
        
        Alamofire.request(method, URLString, parameters: parameters, encoding: encoding, headers: headers).responseJSON {
            (response: Response<AnyObject, NSError>) -> Void in
            
            var res: WMResponseProtocol?
            
            switch response.result {
            case .Success(let v):
//                if URLString.URLString.rangeOfString("baidu.com"){
//                    res = Mapper<WMResponse>().map(v)
//                }else if res is WMWeatherResponse{
                    res = Mapper<WMWeatherResponse>().map(v)
//                }
                
                
                print("\(res)")
                
                if res == nil {
                    res = WMResponse(isSuccess: false, msg: "网络错误", code:100, data:nil)
                } else {
                }
                
            case .Failure(let error):
                res = WMResponse(isSuccess: false, msg: error.localizedDescription, code:error.code, data:nil)
            }
            
            completionHandler(res!)
        }
    }
}