//
//  RootViewController.swift
//  WeatherMan
//
//  Created by kamous on 16/4/26.
//  Copyright © 2016年 kamous. All rights reserved.
//

import UIKit
import KGFloatingDrawer

let RootVCChangeBgNotification = "RootVCChangeBgNotification"
let RootVCCloseDrawerNotification = "RootVCCloseDrawerNotification"
let RootVCOpenDrawerNotification = "RootVCOpenDrawerNotification"
let RootVCNotificationParamSide = "side"


public class RootViewController: KGDrawerViewController {

    var bgView : UIImageView? = nil
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = UIColor.whiteColor()//UIColor(red: 0.643137255, green: 0.712598425, blue:1, alpha: 1)
        
		self.initChildVC()
        self.initBgView()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RootViewController.onRootVCChangeBgNotification(_:)), name: RootVCChangeBgNotification, object: nil)
    }
    
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initChildVC(){
        let indexVC = UIStoryboard(name: "Main",bundle:nil ).instantiateViewControllerWithIdentifier("IndexViewController")
        let weatherListVC = UIStoryboard(name: "Main",bundle:nil ).instantiateViewControllerWithIdentifier("WeatherListViewController")
        
        self.centerViewController = indexVC
        self.leftViewController = weatherListVC
        self.leftDrawerWidth = 250
    }
    
    func initBgView(){
        let bgView = UIImageView.init(frame: self.view.bounds)
        bgView.image = UIImage.init(named: "bg1")
        self.bgView = bgView
        self.view.insertSubview(bgView, atIndex: 0)
    }

//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return UIStatusBarStyle.Default
//    }
    // MARK: - Override
    public override func closeDrawer(side: KGDrawerSide, animated: Bool, complete: (finished: Bool) -> Void) {
        super.closeDrawer(side, animated: animated, complete: complete)
        NSNotificationCenter.defaultCenter().postNotificationName(RootVCCloseDrawerNotification, object: nil, userInfo: [RootVCNotificationParamSide:side.rawValue])
    }
    
    
    public override func openDrawer(side: KGDrawerSide, animated: Bool, complete: (finished: Bool) -> Void) {
        super.openDrawer(side, animated: animated, complete: complete)
        NSNotificationCenter.defaultCenter().postNotificationName(RootVCOpenDrawerNotification, object: nil, userInfo: [RootVCNotificationParamSide:side.rawValue])
        
    }
    // MARK: - Action
    @IBAction func onLeftButtonPressed(sender: AnyObject) {
        
    }
    @IBAction func onRightButtonPressed(sender: AnyObject) {
    }
    
    // MARK: - Notification
    func onRootVCChangeBgNotification(notification: NSNotification){
        let index :Int = Int(arc4random() % 6)
        self.bgView!.image = UIImage.init(named: "bg\(index)")
        
    }

}
