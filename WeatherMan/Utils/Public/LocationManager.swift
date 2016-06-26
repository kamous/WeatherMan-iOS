//
//  LocationManager.swift
//  WeatherMan
//
//  Created by kamous on 16/6/21.
//  Copyright © 2016年 kamous. All rights reserved.
//

import Foundation
import CoreLocation

let kLocationManagerLocation = "location"
let kLocationManagerPlacemark = "placemark"


class LocationManager:NSObject, CLLocationManagerDelegate{
    static let shareManager: LocationManager = LocationManager()
    let locationManager :CLLocationManager
    dynamic var location :CLLocation? = nil
    dynamic var placemark :CLPlacemark? = nil
    private override init(){
        
    	self.locationManager = CLLocationManager()
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 1000
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        print("Location:\(newLocation.coordinate.latitude),\(newLocation.coordinate.longitude):\(newLocation)")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        if let loc = location{
            self.saveLocation()
            self.reverseLocation(loc)
            self.location = loc
            print("Location:\(loc.coordinate.latitude),\(loc.coordinate.longitude):\(loc)")
            
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        if error.code == CLError.Denied.rawValue {
            //拒绝访问
        }
        if error.code == CLError.LocationUnknown.rawValue{
            //无法获取未知信息
        }
    }
    
    func saveLocation(){
        if let loc = self.location{
            let data = NSKeyedArchiver.archivedDataWithRootObject(loc)
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: kLocationManagerLocation)
        }
    }
    
    func lastLocation() -> CLLocation? {
        let data = NSUserDefaults.standardUserDefaults().objectForKey(kLocationManagerLocation)
        var loc: CLLocation?
        if let locData = data {
            loc = NSKeyedUnarchiver.unarchiveObjectWithData(locData as! NSData) as? CLLocation
            return loc
        }
        return loc
    }
    
    func savePlacemark(placemark:CLPlacemark?){
        if let loc = placemark{
            let data = NSKeyedArchiver.archivedDataWithRootObject(loc)
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: kLocationManagerPlacemark)
        }
    }
    
    func lastPlacemark() -> CLPlacemark? {
        let data = NSUserDefaults.standardUserDefaults().objectForKey(kLocationManagerPlacemark)
        var loc: CLPlacemark?
        if let locData = data {
            loc = NSKeyedUnarchiver.unarchiveObjectWithData(locData as! NSData) as? CLPlacemark
            return loc
        }
        return loc
    }
    
    func reverseLocation(location:CLLocation){
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { (placemarks:[CLPlacemark]?,error: NSError?) in
            if (placemarks?.count > 0){
               let placemark = placemarks?.first
               self.savePlacemark(placemark)
               self.placemark = placemark
            }
        }
    }
    
    func codeAddressToLocation(address:String,completion:(placemarks:[CLPlacemark]?) -> Void){

        
        if (address.characters.count < 0){
        	completion(placemarks: nil)
        }
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (places :[CLPlacemark]?, error: NSError?) in
            
            if error == nil && places != nil{
                completion(placemarks: places)
            }
            
        }
    }
    
    
}