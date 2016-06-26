//
//  WeatherListViewController.swift
//  WeatherMan
//
//  Created by kamous on 16/4/25.
//  Copyright © 2016年 kamous. All rights reserved.
//

import UIKit
import ObjectMapper
import SnapKit
import KGFloatingDrawer
import CoreLocation

let kCityInputSection = "CityInputSection"
let kWeatherInfoSection = "WeatherInfoSection"
let kCityNameSection = "kCityNameSection"

class WeatherListViewController: WMBaseViewController,UIGestureRecognizerDelegate {
    var cityDatas:[CityData]? = nil
    var cityNames:[CLPlacemark]? = nil
    var dataSource:[String] = [String]()
    var isShowInputView = false
    var isCitySelectMode = false
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
        let effectView = UIVisualEffectView.init(effect: UIBlurEffect.init(style: UIBlurEffectStyle.Light))
        self.view.insertSubview(effectView,atIndex: 0)
        effectView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view.snp_edges)
        }
        let singTapGes = UITapGestureRecognizer.init(target: self, action: #selector(WeatherListViewController.onSwipeGesture(_:)))
        singTapGes.delegate = self
        self.tableView.addGestureRecognizer(singTapGes)
        
//        let swipeGestureRecognizer = UISwipeGestureRecognizer.init(target: self, action: #selector(WeatherListViewController.onSwipeGesture(_:)))
////        swipeGestureRecognizer.delegate = self
//        self.tableView.addGestureRecognizer(swipeGestureRecognizer)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.initData()
        self.initDataSource()
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - 私有
    func initData(){
        if self.cityDatas == nil {
            let dic = NSUserDefaults.standardUserDefaults().objectForKey("CurentCity") as? [String:AnyObject]
            let curCity = Mapper<CityData>().map(dic)
            if let c = curCity {
                self.cityDatas = [c]
            }
            
        }
            }
    
    func initDataSource(){
        self.dataSource.removeAll()
        self.dataSource.append(kCityInputSection)
        if self.isCitySelectMode {
            self.dataSource.append(kCityNameSection)
        }else{
            self.dataSource.append(kWeatherInfoSection)
        }

    }
   
    func jumpToCenterVC(){
        let rootNav = UIApplication.sharedApplication().keyWindow?.rootViewController as! UINavigationController
        let rootVC = rootNav.viewControllers[0] as! RootViewController
        rootVC.closeDrawer(KGDrawerSide.Left, animated: true, complete: { (finished) in
            
        })
    }
    
    // MARK: - action
    @IBAction func onAddButtonPressed(sender: AnyObject) {
        if !self.isShowInputView {
            self.isShowInputView = true
            self.tableView.insertRowsAtIndexPaths([NSIndexPath.init(forRow: 0, inSection: 0)],withRowAnimation: UITableViewRowAnimation.Automatic)
        }else{
            self.isShowInputView = false
            self.tableView.deleteRowsAtIndexPaths([NSIndexPath.init(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
            self.isCitySelectMode = false
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.25 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                self.initDataSource()
                self.tableView.reloadData()
            })
            
        }
        
    }
    
    func onSwipeGesture(ges: UISwipeGestureRecognizer){
//        if ges.direction == UISwipeGestureRecognizerDirection.Right {
            self.jumpToCenterVC()
//        }
        
    }
    
//    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }

}


// MARK: - UITableView
extension WeatherListViewController: UITableViewDelegate,UITableViewDataSource{
    
    func sectionNameOfSection(section:NSInteger) -> String?{
        if section < 0 || section >= self.dataSource.count {
            return nil
        }
        return self.dataSource[section]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataSource.count;
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionName = self.sectionNameOfSection(section)
        if sectionName == kCityInputSection {
            if self.isShowInputView {
                return 1
            }
        }else if sectionName == kWeatherInfoSection{
            if let citys = self.cityDatas{
                return citys.count
            }
        }else if sectionName == kCityNameSection{
            if let cityNames = self.cityNames{
                return cityNames.count
            }
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let sectionName = self.sectionNameOfSection(indexPath.section)
        if sectionName == kCityInputSection {
         	return 48
        }else if sectionName == kWeatherInfoSection{
            return 87
        }else if sectionName == kCityNameSection{
            return 44
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let sectionName = self.sectionNameOfSection(indexPath.section)
        if sectionName == kCityInputSection {
            let cell:CityInputTableViewCell = tableView.dequeueReusableCellWithIdentifier("CityInputTableViewCell", forIndexPath: indexPath) as! CityInputTableViewCell
           	cell.textField.delegate = self
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }else if sectionName == kWeatherInfoSection {
            let cell:CityWetaherInfoCell = tableView.dequeueReusableCellWithIdentifier("CityWetaherInfoCell", forIndexPath: indexPath) as! CityWetaherInfoCell
            let city = self.cityDatas?[indexPath.row]
            cell.bindWithCityData(city)
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }else if sectionName == kCityNameSection {
            let cell:CityNameCell = tableView.dequeueReusableCellWithIdentifier("CityNameCell", forIndexPath: indexPath) as! CityNameCell
//            let city = self.cityDatas?[indexPath.row]
//            cell.bindWithCityData(city)
            cell.bindWithPlacemark(self.cityNames![indexPath.row])
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
        
    	return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let sectionName = self.sectionNameOfSection(indexPath.section)
        if sectionName == kCityNameSection {
            
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        let sectionName = self.sectionNameOfSection(indexPath.section)
        
        if sectionName == kWeatherInfoSection{
            return true
        }
        return false
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
        }
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }
    
    
}


// MARK: - UITableView
extension WeatherListViewController:UITextFieldDelegate{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.text?.characters.count > 0 {
            LocationManager.shareManager.codeAddressToLocation(textField.text!, completion: { (placemarks:[CLPlacemark]?) in
                if let places = placemarks{
//                    print("[[[[L:%f,%f",loc.coordinate.latitude,loc.coordinate.longitude)
                    self.isCitySelectMode = true
                    self.cityNames = places
                    self.initDataSource()
                    self.tableView.reloadData()
                }
            })
        }
        return true
    }
}
