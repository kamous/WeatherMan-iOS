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

class WeatherListViewController: WMBaseViewController,UIGestureRecognizerDelegate {
    var cityDatas:[CityData]? = nil
    var isShowInputView = false
    
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
        
        self.initDataSource()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - 私有
    func initDataSource(){
        if self.cityDatas == nil {
            let dic = NSUserDefaults.standardUserDefaults().objectForKey("CurentCity") as? [String:AnyObject]
            let curCity = Mapper<CityData>().map(dic)
            if let c = curCity {
                self.cityDatas = [c]
            }
            
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
            self.tableView .insertRowsAtIndexPaths([NSIndexPath.init(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
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
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if self.isShowInputView {
                return 1
            }
        }else{
            if let citys = self.cityDatas{
                return citys.count
            }
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
         	return 48
        }else{
            return 87
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell:CityInputTableViewCell = tableView.dequeueReusableCellWithIdentifier("CityInputTableViewCell", forIndexPath: indexPath) as! CityInputTableViewCell
           
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }else{
            let cell:CityWetaherInfoCell = tableView.dequeueReusableCellWithIdentifier("CityWetaherInfoCell", forIndexPath: indexPath) as! CityWetaherInfoCell
            let city = self.cityDatas?[indexPath.row]
            cell.bindWithCityData(city)
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
        
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == 0 {
        	return false
        }
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
        }
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }
    
    
}