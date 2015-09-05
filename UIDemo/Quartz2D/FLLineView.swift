//
//  FLLineView.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/7/5.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class FLLineView: UIView {

    /**/
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        drawTriangle();
        drawMyRect();
        drawCircle();
        drawArc();
    }


    func drawTriangle(){
        
        // 1.获取上下文
        var ctx:CGContextRef=UIGraphicsGetCurrentContext()
        
        // 保存上下文状态
        CGContextSaveGState(ctx)
        
        // 2.拼接路径
        var path:UIBezierPath=UIBezierPath()
        // 3.设置起点
        path.moveToPoint(CGPointMake(10, 10))
        
        path.addLineToPoint(CGPointMake(10, 100))
        path.addLineToPoint(CGPointMake(100, 100))
        path.closePath()
        //path.fill()
        // 4.添加到上下文
        CGContextAddPath(ctx, path.CGPath)
        
        UIColor.blueColor().setFill()
        UIColor.redColor().setStroke()
        CGContextSetLineWidth(ctx, 5)
        // 5.渲染到上下文
        //CGContextStrokePath(ctx)
        
        // 恢复上下文状态
        //CGContextRestoreGState(ctx)
        
        //CGContextFillPath(ctx)
        
        CGContextDrawPath(ctx, kCGPathFillStroke)
        
        
    }
    
    func drawMyRect(){
        var ctx:CGContextRef=UIGraphicsGetCurrentContext()
        // 恢复上下文状态
        //CGContextRestoreGState(ctx)
        var path:UIBezierPath=UIBezierPath(rect: CGRectMake(10, 10, 180, 180))
        CGContextAddPath(ctx, path.CGPath)
        CGContextStrokePath(ctx)
    }
    
    func drawCircle(){
        var ctx:CGContextRef=UIGraphicsGetCurrentContext()
        var path:UIBezierPath=UIBezierPath(ovalInRect: CGRectMake(10, 10, 150, 150))
        CGContextAddPath(ctx, path.CGPath)
        CGContextStrokePath(ctx)
    }
    
    func drawArc(){
        var ctx:CGContextRef=UIGraphicsGetCurrentContext()
        var center:CGPoint=CGPointMake(100, 100)
        var radius:CGFloat=50
        var startP:CGFloat=0
        var endP:CGFloat=CGFloat(M_PI)
        
        var path:UIBezierPath=UIBezierPath(arcCenter: center, radius: radius, startAngle: startP, endAngle: endP, clockwise: false)
        CGContextAddPath(ctx, path.CGPath)
        CGContextStrokePath(ctx)
        
    }
    
}
