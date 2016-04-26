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

class IndexViewController: BaseViewController {
    var headerView :IndexHeaderView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initHeaderView()
        
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initHeaderView(){
        let headerView :IndexHeaderView = NSBundle.mainBundle().loadNibNamed("IndexHeaderView", owner: self, options: nil)[0] as! IndexHeaderView
        self.view.addSubview(headerView)
        headerView.snp_makeConstraints { (make) in
            make.leading.top.trailing.equalTo(headerView.superview!)
            make.height.equalTo(80)
        }
        self.headerView = headerView
        
    }
    
    func loadData(){
        var urlStr = "http://api.map.baidu.com/telematics/v3/weather?location=北京&output=json&ak=\(BaiduManager.appKey)&mcode=com.kamous.WeatherMan"
        urlStr = urlStr.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        WMNetwork.shareManager.request(Alamofire.Method.GET, urlStr) { (response:WMResponse) in
            if response.isSuccess{
                print("Success:\(response.data)")
            }else{
                print("Failed:\(response.data)")
            }
        }
    }
    
    // MARK: - Action
    @IBAction func onLeftButtonPressed(sender: AnyObject) {
        let rootNav = UIApplication.sharedApplication().keyWindow?.rootViewController as! UINavigationController
        let rootVC = rootNav.viewControllers[0] as! RootViewController
        rootVC.openDrawer(KGDrawerSide.Left, animated: true) { (finished) in
            
        }
        
        
    }
    @IBAction func onRightButtonPressed(sender: AnyObject) {
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
        let cell = tableView.dequeueReusableCellWithIdentifier("weatherPicCell", forIndexPath: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
        
    }
}
