//
//  CPNavigationViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/8.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CPNavigationViewController: UINavigationController {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(rootViewController:UIViewController){
        super.init(rootViewController: rootViewController)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if(self.isKindOfClass(CPNavigationViewController)){
            // 1.设置导航条外观
            setupNav();
            if(!DeviceHandler.IsGtIOS7){ // sdk<7.0
                // 2.设置全局barButton外观
                setupBarButton();
            }

        }

        //NSLog("%@", __FUNCTION__)
    }
    // MARK: - 设置全局的Navigation
    func setupNav(){
        // 获取应用程序中所有的导航条
        // 获取所有导航条外观
        var bar:UINavigationBar=UINavigationBar.appearance()
        if(DeviceHandler.IsGtIOS7){
            bar.setBackgroundImage(UIImage(named: "NavBar64"), forBarMetrics: UIBarMetrics.Default)
        }
        else{
            bar.setBackgroundImage(UIImage(named: "NavBar"), forBarMetrics: UIBarMetrics.Default)
        }
        var dict:NSDictionary=[NSForegroundColorAttributeName:UIColor.whiteColor(),NSFontAttributeName:UIFont.systemFontOfSize(15)]
        bar.titleTextAttributes=dict as [NSObject : AnyObject]
        // 设置导航条主题颜色
        bar.tintColor=UIColor.whiteColor()
    }
    // MARK: - 设置全局的UIBarButton外观
    func setupBarButton(){
        // 获取所有UIBarButtionItem的外观
        var buttonItem=UIBarButtonItem.appearance()
        buttonItem.setBackgroundImage(UIImage(named: "NavButton"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        buttonItem.setBackgroundImage(UIImage(named: "NavButtonPressed"), forState: UIControlState.Highlighted, barMetrics: UIBarMetrics.Default)
        
        // 设置反悔按钮的背景图片
        buttonItem.setBackButtonBackgroundImage(UIImage(named: "NavBackButton"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        buttonItem.setBackButtonBackgroundImage(UIImage(named: "NavBackButtonPressed"), forState: UIControlState.Highlighted, barMetrics: UIBarMetrics.Default)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func showViewController(vc: UIViewController, sender: AnyObject!) {
        vc.hidesBottomBarWhenPushed=true
        super.showViewController(vc, sender: sender)

    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed=true
        super.pushViewController(viewController, animated: animated)
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
