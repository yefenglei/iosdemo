//
//  CPAboutHeaderView.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/9/4.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CPAboutHeaderView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    static func HeaderView()->CPAboutHeaderView{
        return NSBundle.mainBundle().loadNibNamed("CPAboutHeaderView", owner: nil, options: nil).last as! CPAboutHeaderView
    }

}
