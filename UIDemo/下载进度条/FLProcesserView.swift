//
//  FLProcesserView.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/7/5.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class FLProcesserView: UIView {

    private var _processValue:Float=0
    var processValue:Float{
        set{
            _processValue=newValue
            label.text=NSString(format: "%.2f%%", newValue*100) as String
            setNeedsDisplay()
        }
        get{
            return _processValue
        }
    }
    var label:UILabel=UILabel()

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.label.text="0.00%";
        self.label.frame=CGRectMake(0, 0, 140, 140)
        self.label.textAlignment=NSTextAlignment.Center
        self.addSubview(self.label)
    }
    
    /**/
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        drawCircle()
        
    }
    
    func drawCircle(){
        var ctx:CGContextRef=UIGraphicsGetCurrentContext()
        var center=CGPointMake(70, 70)
        var radius:CGFloat=60
        var startA:CGFloat = CGFloat( -M_PI_2 )
        var endA:CGFloat = CGFloat( -M_PI_2 + Double(self.processValue) * M_PI*2)
        
        var path:UIBezierPath=UIBezierPath(arcCenter: center, radius: radius, startAngle: startA, endAngle: endA, clockwise: true)
        CGContextAddPath(ctx, path.CGPath)
        CGContextStrokePath(ctx)
        
    }

}
