//
//  FLJumpViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/7/4.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class FLJumpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.blueColor()
        var btn:UIButton=UIButton.buttonWithType(UIButtonType.ContactAdd) as! UIButton
        btn.center=self.view.center
        
        btn.addTarget(self, action: "Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(btn)
        

        // Do any additional setup after loading the view.
    }
    func Clicked(){
        self.dismissViewControllerAnimated(true, completion: nil)
       
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
