//
//  WeatherListViewController.swift
//  WeatherMan
//
//  Created by kamous on 16/4/25.
//  Copyright © 2016年 kamous. All rights reserved.
//

import UIKit
import ObjectMapper

class WeatherListViewController: WMBaseViewController {
    var cityDatas:[CityData]? = nil
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
    

}


// MARK: - UITableView
extension WeatherListViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let citys = self.cityDatas{
        	return citys.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CityWetaherInfoCell = tableView.dequeueReusableCellWithIdentifier("CityWetaherInfoCell", forIndexPath: indexPath) as! CityWetaherInfoCell
        let city = self.cityDatas?[indexPath.row]
        cell.bindWithCityData(city)
        return cell
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
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