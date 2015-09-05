//
//  CPWheelView.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/9/5.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CPWheelView: UIView {
    @IBOutlet weak var rotationView: UIImageView!
    var _selectedButton:UIButton?
    var link:CADisplayLink?
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    static func wheelView()->CPWheelView{
        return NSBundle.mainBundle().loadNibNamed("CPWheelView", owner: nil, options: nil).last as! CPWheelView
    }
    
    override func awakeFromNib() {
        // 开启用户交互
        rotationView.userInteractionEnabled = true
        // 裁剪的大图片
        var bigImage:UIImage=UIImage(named: "LuckyAstrology")!
        var selectedImage:UIImage=UIImage(named:"LuckyAstrologyPressed")!
        // 图片的尺寸
        var imageW:CGFloat=40 * UIScreen.mainScreen().scale
        var imageH:CGFloat=47 * UIScreen.mainScreen().scale
        for i:Int in 0...11{
            // 创建按钮
            var button:CPWheelButton=CPWheelButton()
            // 锚点
            button.layer.anchorPoint=CGPointMake(0.5, 1)
            // 位置
            button.layer.position=CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5)
            // 旋转按钮
            button.layer.transform=CATransform3DMakeRotation(angle2radian(Double(i*30)), 0, 0, 1)
            button.adjustsImageWhenHighlighted=false
            // 尺寸
            button.bounds=CGRectMake(0, 0, 68, 143)
            // 设置选中时候的图片
            button.setBackgroundImage(UIImage(named: "LuckyRototeSelected"), forState: UIControlState.Selected)
            // 设置按钮图片
            // bigImage:裁剪图片
            // clipRect:裁剪的尺寸
            var clipRect:CGRect=CGRectMake(CGFloat(i) * imageW, 0, imageW, imageH)
            var smallimage=CGImageCreateWithImageInRect(bigImage.CGImage, clipRect)
            button.setImage(UIImage(CGImage: smallimage), forState: UIControlState.Normal)
            // 设置选中的图片
            var selectedsmallimage=CGImageCreateWithImageInRect(selectedImage.CGImage, clipRect)
            button.setImage(UIImage(CGImage: selectedsmallimage), forState: UIControlState.Selected)
            
            // 监听点击事件
            button.addTarget(self, action: "btnClicked:", forControlEvents: UIControlEvents.TouchDown)
            rotationView.addSubview(button)
            
            if(0==i){
                self.btnClicked(button)
            }
        }
    }
    
    func btnClicked(button:UIButton){
        if(_selectedButton != nil){
            _selectedButton!.selected=false
        }
        button.selected=true
        _selectedButton=button
    }
    
    func angle2radian(angle:Double)->CGFloat{
        return CGFloat(angle / 180.0 * M_PI)
    }
    
    // 开始旋转
    func startRotate(){
        if(link == nil){
            link=CADisplayLink(target: self, selector: "update")
            link!.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
        }else{
            link!.paused=false
        }

    }
    // 停止旋转
    func endRotate(){
        if(link != nil){
            link!.paused=true
        }
    }
    
    func update(){
        rotationView.transform=CGAffineTransformRotate(rotationView.transform, angle2radian(Double(45.0/60.0)))
    }
    @IBAction func start(sender: UIButton) {
        // 1.不要和用户交互
        rotationView.userInteractionEnabled=false
        // 2.取消慢慢的旋转
        self.endRotate()
        var anime=CABasicAnimation()
        anime.keyPath="transform.rotation"
        anime.toValue=M_PI*2*3
        anime.duration=0.5
        anime.delegate=self
        rotationView.layer.addAnimation(anime, forKey: nil)
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        rotationView.userInteractionEnabled=true
        if let selectedBtn=_selectedButton{
            // 让选中按钮回到最上面的中间位置
            var angle:CGFloat=atan2(selectedBtn.transform.b, selectedBtn.transform.a)
            // 把我们的转盘反转那么多°
            rotationView.transform=CGAffineTransformMakeRotation(-angle)
        }

    }
}
