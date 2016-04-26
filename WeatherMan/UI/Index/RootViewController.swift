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
        self.view.backgroundColor = UIColor.whiteColor()
		self.initChildVC()
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

    
    
    // MARK: - Action
    @IBAction func onLeftButtonPressed(sender: AnyObject) {
        
    }
    @IBAction func onRightButtonPressed(sender: AnyObject) {
    }

}
