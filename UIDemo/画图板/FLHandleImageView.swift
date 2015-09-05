//
//  FLHandleImageView.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/7/9.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

typealias callbackfunc=(image:UIImage)->Void

class FLHandleImageView: UIView,UIGestureRecognizerDelegate {
    
    var FLHandleImageViewBlock=callbackfunc?()
    var image:UIImage?
    var imageView:UIImageView!
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame=frame
        // 添加UIImageView
        addImageView()
        // 添加手势
        addGestureRecognizers()
        addRotation()
        addPinch()
    }


    func addImageView(){
        imageView=UIImageView(frame: self.bounds)
        imageView.userInteractionEnabled=true // 允许用户交互
        self.addSubview(imageView)
    }
    
    func setUIImage(image:UIImage){
        self.image=image
        imageView.image=self.image
    }
    // 添加长按手势
    func addGestureRecognizers(){
        // 1.长按
        var longPress:UILongPressGestureRecognizer=UILongPressGestureRecognizer(target: self, action: "longpress:")
        self.imageView.addGestureRecognizer(longPress)
    }
    
    func longpress(longPress:UILongPressGestureRecognizer){
        if(longPress.state == UIGestureRecognizerState.Ended){
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.imageView.alpha=0.3
            }, completion: { (finished) -> Void in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.imageView.alpha=1
                }, completion: { (finished) -> Void in
                    // 1.截屏
                    var newImage:UIImage=UIImage.imageWithCaptureView(self)
                    // 2.把图片传给控制器
                    self.FLHandleImageViewBlock!(image: newImage)
                    // 3.把自己移除父控件
                    self.removeFromSuperview()
                })
            })

        }
    }
    
    // 添加旋转手势
    func addRotation(){
        var rotation:UIRotationGestureRecognizer=UIRotationGestureRecognizer(target: self, action: "rotation:")
        self.imageView.addGestureRecognizer(rotation)
    }
    
    func rotation(rotation:UIRotationGestureRecognizer){
        self.imageView.transform=CGAffineTransformRotate(self.imageView.transform, rotation.rotation)
        // 复位
        rotation.rotation=0
    }
    
    // 添加缩放手势
    func addPinch(){
        var pinch:UIPinchGestureRecognizer=UIPinchGestureRecognizer(target: self, action: "pinch:")
        pinch.delegate=self
        self.imageView.addGestureRecognizer(pinch)
    }
    
    func pinch(pinch:UIPinchGestureRecognizer){
        self.imageView.transform=CGAffineTransformScale(self.imageView.transform, pinch.scale, pinch.scale)
        // 复位
        pinch.scale=1
    }
    
    // 开启多手势支持
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}
