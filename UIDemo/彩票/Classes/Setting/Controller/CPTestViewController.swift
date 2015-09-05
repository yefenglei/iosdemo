//
//  CPTestViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/9.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CPTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.bounds=UIScreen.mainScreen().bounds
        self.view.backgroundColor=UIColor.whiteColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
