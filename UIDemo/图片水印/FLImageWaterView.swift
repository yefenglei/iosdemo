//
//  FLImageWaterView.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/7/5.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class FLImageWaterView: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        var oldImage:UIImage = UIImage(named: "ad_00")!
        
        // 开启上下文
        UIGraphicsBeginImageContextWithOptions(oldImage.size, false, 1)
        
        oldImage.drawAtPoint(CGPointZero)
        
        var text:NSString="楼主傻逼"
        var dict:NSDictionary = [NSFontAttributeName:UIFont.systemFontOfSize(15),NSForegroundColorAttributeName:UIColor.redColor()]
        text.drawAtPoint(CGPointMake(140, 150), withAttributes: dict as [NSObject : AnyObject])
        
        // 获取新的图片
        var newImage:UIImage=UIGraphicsGetImageFromCurrentImageContext()
        
        // 关闭上下文
        UIGraphicsEndImageContext()
    }


}
