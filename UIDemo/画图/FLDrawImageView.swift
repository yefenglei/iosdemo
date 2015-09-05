//
//  FLDrawImageView.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/7/5.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class FLDrawImageView: UIView {

    var imgY:CGFloat=10
    override func awakeFromNib() {
        // 刷新屏幕的时候 重绘图片
        var link:CADisplayLink=CADisplayLink(target: self, selector: "setNeedsDisplay")
        link.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        imgY += 1
        // Drawing code
        var img:UIImage = UIImage(named: "002")!
        img.drawAtPoint(CGPointMake(10, imgY))
        
        if(imgY>self.frame.height){
            imgY=0
        }
    }


}
