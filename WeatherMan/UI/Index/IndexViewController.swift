//
//  IndexViewController.swift
//  WeatherMan
//
//  Created by kamous on 16/4/25.
//  Copyright © 2016年 kamous. All rights reserved.
//

import UIKit
import SnapKit
import KGFloatingDrawer
import Alamofire
import ObjectMapper
import CoreLocation

let CYToken = "s2Z8DUdCylyrd=8k"

class IndexViewController: WMBaseViewController {
    var headerView :IndexHeaderView? = nil
    var cityInfo: CityInfo?
//    var dataModel :WeatherModel = WeatherModel.shareInstance
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initHeaderView()
        
		LocationManager.shareManager.addObserver(self, forKeyPath: kLocationManagerLocation, options:NSKeyValueObservingOptions.New, context: nil)
        LocationManager.shareManager.addObserver(self, forKeyPath: kLocationManagerPlacemark, options:NSKeyValueObservingOptions.New, context: nil)
        
        
//        self.loadData()
        self.loadCYData()
        
        let swipeGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(IndexViewController.onSwipeGesture(_:)))
        self.view.addGestureRecognizer(swipeGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - 私有方法
    func initHeaderView(){
        let headerView :IndexHeaderView = NSBundle.mainBundle().loadNibNamed("IndexHeaderView", owner: self, options: nil)[0] as! IndexHeaderView
        self.view.addSubview(headerView)
        headerView.snp_makeConstraints { (make) in
            make.leading.top.trailing.equalTo(headerView.superview!)
            make.height.equalTo(80)
        }
        self.headerView = headerView
        
    }
    
    func updateHeaderView(){

        self.headerView?.titleLabel.text = self.cityInfo?.placemark?.name
        self.headerView?.subTitleLabel.text = self.cityInfo?.placemark?.thoroughfare
    }
    
//    func loadData(){
//        var urlStr = "http://api.map.baidu.com/telematics/v3/weather?location=杭州&output=json&ak=\(BaiduManager.appKey)&mcode=com.kamous.WeatherMan"
//        urlStr = urlStr.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
//        WMNetwork.shareManager.request(Alamofire.Method.GET, urlStr) { (response:WMResponseProtocol) in
//            if response.isSuccess{
//                var result = Mapper<WeatherResult>().map(response.data)
//                self.cityData = result?.results?.first
//                self.saveDataSource()
//                self.tableView.reloadData()
//                self.updateHeaderView()
////                print("Success:\(response.data)")
//            }else{
//                print("Failed:\(response.data)")
//            }
//        }
//    }
    
    func loadCYData(){
 
        self.cityInfo = CityManager.shareManager.getCurCity()
//        self.saveDataSource()
        WeatherModel.shareInstance.loadData((cityInfo?.location?.latitude)!, longitude: (cityInfo?.location?.longitude)!) { (isSuccess:Bool) in
            if let weather = WeatherModel.shareInstance.weatherRealTime{
                self.cityInfo?.weather = weather
                CityManager.shareManager.saveCurCity(self.cityInfo)
            }
            self.tableView.reloadData()
            self.updateHeaderView()
        }
    }
    
    
    func jumpToLeftVC(){
        let rootNav = UIApplication.sharedApplication().keyWindow?.rootViewController as! UINavigationController
        let rootVC = rootNav.viewControllers[0] as! RootViewController
        rootVC.openDrawer(KGDrawerSide.Left, animated: true) { (finished) in
            
        }
    }
    
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == kLocationManagerLocation {
            self.loadCYData()
        }else if keyPath == kLocationManagerPlacemark{
            self.cityInfo?.placemark = Placemark(placemark: LocationManager.shareManager.placemark)
            CityManager.shareManager.saveCurCity(self.cityInfo)
            self.updateHeaderView()
        }
    }
    
    
    
    // MARK: - Action
    @IBAction func onLeftButtonPressed(sender: AnyObject) {
        
        self.jumpToLeftVC()
        
    }
    @IBAction func onRightButtonPressed(sender: AnyObject) {
        IndicatorView.showString("正在开发中。。。")
    }
    
    func onSwipeGesture(ges: UISwipeGestureRecognizer){
        if ges.direction == UISwipeGestureRecognizerDirection.Right {
            self.jumpToLeftVC()
        }
        
    }
}


// MARK: - UITableView
extension IndexViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.view.frame.size.height //- (self.headerView?.frame.size.height)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:WeatherInfoCell = tableView.dequeueReusableCellWithIdentifier("WeatherInfoCell", forIndexPath: indexPath) as! WeatherInfoCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
//        let weather : WeatherData? = self.cityData?.weatherDatas?[0]
//        cell.bindWithWeatherData(weather)
        cell.bindWithWeatherRealTime(self.cityInfo?.weather)
        return cell
        
    }
}
