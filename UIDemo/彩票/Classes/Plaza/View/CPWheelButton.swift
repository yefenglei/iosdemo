//
//  CPWheelButton.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/9/5.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CPWheelButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect{
        var imageW:CGFloat=40
        var imageH:CGFloat=47
        var imageX:CGFloat=(contentRect.size.width-imageW)/2
        var imageY:CGFloat=20
        return CGRectMake(imageX, imageY, imageW,imageH )
    }
    
    override var highlighted: Bool{
        set{
            
        }
        get{
            return false
        }
    }

}
