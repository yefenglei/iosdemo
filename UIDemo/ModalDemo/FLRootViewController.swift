//
//  FLRootViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/7/4.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class FLRootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var btn:UIButton=UIButton.buttonWithType(UIButtonType.ContactAdd) as! UIButton
        btn.center=self.view.center
        
        btn.addTarget(self, action: "Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(btn)

        // Do any additional setup after loading the view.
    }
    
    func Clicked(){
        // 创建控制器对象
        var jump:FLJumpViewController=FLJumpViewController()
        
        // Modal 出一个控制器]
        self.presentViewController(jump, animated: true, completion: nil)
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
