//
//  IndexViewController.swift
//  WeatherMan
//
//  Created by kamous on 16/4/25.
//  Copyright © 2016年 kamous. All rights reserved.
//

import UIKit

class IndexViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


// MARK: - UITableView
extension IndexViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("weatherPicCell", forIndexPath: indexPath)
        
        return cell
        
    }
}
