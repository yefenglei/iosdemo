//
//  FLImageClipViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/7/5.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class FLImageClipViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        ClipImage()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ClipImage(){
        // 圆环宽度
        var borderW:CGFloat=5
        
        // 加载旧的图片
        var oldImage:UIImage = UIImage(named: "ad_00")!
        
        // 新的图片尺寸
        var imageW:CGFloat = oldImage.size.width+2*borderW
        var imageH:CGFloat = oldImage.size.height+2*borderW
        
        // 设置新的图片尺寸
        var circleW:CGFloat=imageW > imageH ?imageH:imageW
        
        // 开启上下文
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(circleW, circleW), false, 0.0)
        // 画大圆
        var path:UIBezierPath=UIBezierPath(ovalInRect: CGRectMake(0, 0, circleW, circleW))
        // 获取当前上下文
        var ctx:CGContextRef=UIGraphicsGetCurrentContext()
        
        CGContextAddPath(ctx, path.CGPath)
        UIColor.whiteColor().set()
        //渲染
        CGContextFillPath(ctx)
        
        var newImageW:CGFloat = oldImage.size.width>oldImage.size.height ?oldImage.size.height : oldImage.size.width
        // 画圆 正切于旧图片
        var clipR:CGRect=CGRectMake(borderW, borderW, newImageW, newImageW)
        
        var clipPath:UIBezierPath=UIBezierPath(ovalInRect: clipR)
        
        // 设置裁剪区域
        clipPath.addClip()
        
        // 画图片
        oldImage.drawAtPoint(CGPointMake(borderW, borderW))
        
        // 获取新的图片
        var newImage:UIImage=UIGraphicsGetImageFromCurrentImageContext()
        
        // 关闭上下文
        UIGraphicsEndImageContext()
        
        imageView.image=newImage
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
