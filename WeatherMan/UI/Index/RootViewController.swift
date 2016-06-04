//
//  RootViewController.swift
//  WeatherMan
//
//  Created by kamous on 16/4/26.
//  Copyright © 2016年 kamous. All rights reserved.
//

import UIKit
import KGFloatingDrawer

class RootViewController: KGDrawerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = UIColor.whiteColor()//UIColor(red: 0.643137255, green: 0.712598425, blue:1, alpha: 1)
        
		self.initChildVC()
        self.initBgView()
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
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
        self.view.insertSubview(bgView, atIndex: 0)
    }

//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return UIStatusBarStyle.Default
//    }
    
    
    // MARK: - Action
    @IBAction func onLeftButtonPressed(sender: AnyObject) {
        
    }
    @IBAction func onRightButtonPressed(sender: AnyObject) {
    }

}
