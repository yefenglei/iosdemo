//
//  FLPaintPath.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/7/9.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class FLPaintPath: UIBezierPath {
    var color:UIColor!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(lineWidth:CGFloat,lineColor:UIColor,startPoint:CGPoint){
        super.init()
        color=lineColor
        self.lineWidth=lineWidth
        self.moveToPoint(startPoint)
    }
}
