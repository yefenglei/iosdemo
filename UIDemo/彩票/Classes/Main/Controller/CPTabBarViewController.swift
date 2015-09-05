//
//  CPTabBarViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/1.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CPTabBarViewController: UITabBarController,tabBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // 创建tabBar
        var tabBar=CPTabBar(frame: self.tabBar.bounds)
//        tabBar.tabBarClickBlock={(selectedIndex)-> Void in
//            self.selectedIndex=selectedIndex
//        }
        tabBar.delegate=self
        tabBar.backgroundColor=UIColor.blackColor()
        
        for i in 1...self.childViewControllers.count{
            // 添加底部按钮
            tabBar.addTabBarButton("TabBar\(i)", selName: "TabBar\(i)Sel")
        }
        // 移除自带的tabBar
        // self.tabBar.removeFromSuperview()
        
        self.tabBar.addSubview(tabBar)
    

        
    }
    
    // 切换控制器
    func tabBar(didSelectedIndex: Int) {
        self.selectedIndex=didSelectedIndex
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
