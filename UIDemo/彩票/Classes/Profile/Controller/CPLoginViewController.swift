//
//  CPLoginViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/9.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CPLoginViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var btnImage=UIImage.resizeWithImageName("RedButton")
        var btnPressedImage=UIImage.resizeWithImageName("RedButtonPressed")
        loginBtn.setBackgroundImage(btnImage, forState: UIControlState.Normal)
        loginBtn.setBackgroundImage(btnPressedImage, forState: UIControlState.Highlighted)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 跳转到设置界面
    @IBAction func Setting(sender: UIBarButtonItem) {
        // 1. 创建设置控制器
        var settingTBV=CPSettingTableViewController()

        // 2. 调整到设置界面
        self.navigationController?.showViewController(settingTBV, sender: self)
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
