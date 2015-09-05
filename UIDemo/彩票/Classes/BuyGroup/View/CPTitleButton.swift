//
//  CPTitleButton.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/9.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CPTitleButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    // 不能使用self.titleLabel 会死循环
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        var titleX:CGFloat=0
        var titleY:CGFloat=0
        var titleW:CGFloat=0
        var dict:NSDictionary=[NSFontAttributeName:UIFont.systemFontOfSize(15)]
        if(DeviceHandler.IsGtIOS7){
            #if __IPHONE_7_0
            titleW=(self.currentTitle! as NSString).textRectWithSize(CGSizeMake(CGFloat.max, CGFloat.max), attributes: dict).size.width
            #else
                titleW=(self.currentTitle! as NSString).sizeWithAttributes(dict as [NSObject : AnyObject]).width
            #endif
        }else{
            titleW=(self.currentTitle! as NSString).sizeWithAttributes(dict as [NSObject : AnyObject]).width
        }
        
        
        var titleH:CGFloat=contentRect.size.height
        return CGRectMake(titleX, titleY, titleW, titleH)
    }
    
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        var imageX:CGFloat=30
        var imageY:CGFloat=0
        var imageW:CGFloat=contentRect.size.width
        var imageH:CGFloat=contentRect.size.height
        return CGRectMake(imageX, imageY, imageW, imageH)
    }
    
    override func awakeFromNib() {
        self.imageView!.contentMode=UIViewContentMode.Center
    }
}
