//
//  BaseViewController.swift
//  WeatherMan
//
//  Created by kamous on 16/4/26.
//  Copyright © 2016年 kamous. All rights reserved.
//

import UIKit

class WMBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
