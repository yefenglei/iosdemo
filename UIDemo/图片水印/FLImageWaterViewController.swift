//
//  FLImageWaterViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/7/5.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class FLImageWaterViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var oldImage:UIImage = UIImage(named: "ad_00")!
        
        // 开启上下文
        UIGraphicsBeginImageContextWithOptions(oldImage.size, false, 1)
        
        oldImage.drawAtPoint(CGPointZero)
        
        var text:NSString="楼主傻逼"
        var dict:NSDictionary = [NSFontAttributeName:UIFont.systemFontOfSize(15),NSForegroundColorAttributeName:UIColor.redColor()]
        text.drawAtPoint(CGPointMake(200, 180), withAttributes: dict as [NSObject : AnyObject])
        
        // 获取新的图片
        var newImage:UIImage=UIGraphicsGetImageFromCurrentImageContext()
        
        // 关闭上下文
        UIGraphicsEndImageContext()
        
        imageView.image=newImage
        
        

        // Do any additional setup after loading the view.
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
