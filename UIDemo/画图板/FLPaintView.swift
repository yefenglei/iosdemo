//
//  FLPaintView.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/7/9.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class FLPaintView: UIView {
    var lineWith:CGFloat=2
    var color:UIColor=UIColor.blackColor()
    var path:FLPaintPath!
    var paths:[FLPaintPath]=[FLPaintPath]()
    var image:UIImage?
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        if(self.image != nil){
            image?.drawAtPoint(CGPointZero)
        }
        
        for path in self.paths {
            path.color.set()
            path.stroke()
        }
        
    }
    
    func pointWithTouches(touches:Set<NSObject>)->CGPoint{
        var touch:UITouch=touches.first as! UITouch
        return touch.locationInView(self)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        // 获取触摸点
        var pos:CGPoint=self.pointWithTouches(touches)
        path=FLPaintPath(lineWidth: self.lineWith,lineColor: self.color,startPoint: pos)
        paths.append(path)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        // 获取触摸点
        var pos:CGPoint=self.pointWithTouches(touches)
        // 确定终点
        path.addLineToPoint(pos)
        
        self.setNeedsDisplay()
        
    }
    // 清屏
    func clearScreen(){
        self.paths.removeAll(keepCapacity: true)
        self.image = nil
        self.setNeedsDisplay()
    }
    // 撤销
    func undo(){
        if(self.paths.count>0){
            self.paths.removeLast()
        }
        self.setNeedsDisplay()
    }
    // 橡皮擦
    func eraser(){
        color=UIColor.whiteColor()
    }
    // 保存 到相册
    func save(){

    }
    
    func setUIImage(image:UIImage){
        self.image=image
        self.setNeedsDisplay()
    }
}
