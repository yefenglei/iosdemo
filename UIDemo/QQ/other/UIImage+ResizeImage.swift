//
//  UIImage+ResizeImage.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/6/18.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import Foundation
import UIKit
extension UIImage{
    static func resizeWithImageName(name:String)->UIImage{
        var normal=UIImage(named: name)
        var w:CGFloat=normal!.size.width*0.5
        var h:CGFloat=normal!.size.height*0.5
        //传入上下左右不需要拉升的边距，只拉伸/填铺中间部分

        return normal!.resizableImageWithCapInsets(UIEdgeInsetsMake(h, w, h, w))
        // 1 = width - leftCapWidth  - right
        // 1 = height - topCapHeight  - bottom
        
        //传入上下左右不需要拉升的编剧，只拉伸中间部分，并且传入模式（平铺/拉伸）
        //    [normal :<#(UIEdgeInsets)#> resizingMode:<#(UIImageResizingMode)#>]
        
        //只用传入左边和顶部不需要拉伸的位置，系统会算出右边和底部不需要拉升的位置。并且中间有1X1的点用于拉伸或者平铺
        // 1 = width - leftCapWidth  - right
        // 1 = height - topCapHeight  - bottom
        //    return [normal stretchableImageWithLeftCapWidth:w topCapHeight:h];
    }
    
    static func imageWithCaptureView(captureView:UIView)->UIImage{
        // 把画板截屏
        // 开启上下文
        UIGraphicsBeginImageContextWithOptions(captureView.bounds.size, false, 0.0)
        // 获取当前上下文
        var ctx:CGContextRef=UIGraphicsGetCurrentContext()
        // 把画板上的内容渲染到上下文
        captureView.layer.renderInContext(ctx)
        // 获取新的图片
        var newImage:UIImage=UIGraphicsGetImageFromCurrentImageContext()
        
        return newImage
    }
}