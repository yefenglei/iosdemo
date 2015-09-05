//
//  WBStatusFrame.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/6/14.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import Foundation
import UIKit

class WBStatusFrame{
    /* 所有控件的位置 */
    var iconF:CGRect?
    var nameF:CGRect?
    var vipF:CGRect?
    var textF:CGRect?
    var pictureF:CGRect?
    /* 行高 */
    var cellHeight:CGFloat!
    /* 所有空间的尺寸都可以通过Status来计算得出 */
    var status:WBStatus?
    /** 所有的statusFrame数据数组 */
    
    /** 姓名字体 */
    let kNameFont=UIFont.systemFontOfSize(14)
    /** 正文字体 */
    let kTextFont=UIFont.systemFontOfSize(16)
    
    func setStatus(status:WBStatus){
        self.status=status
        // 0. 定义间距
        let padding:CGFloat=10
        // 1. 头像
        let iconX:CGFloat=padding
        let iconY:CGFloat=padding
        let iconW:CGFloat=30
        let iconH:CGFloat=30
        self.iconF=CGRectMake(iconX, iconY, iconW, iconH)
        // 2. 姓名大小由文字的长度来决定
        // boundingRectWithSize计算给定文本字符串所占的区域
        // 返回值是一个x,y = 0的CGRect,w,h是计算好的宽高
        //
        // 如果要计算多行的准确高度，需要传入NSStringDrawingUsesLineFragmentOrigin选项
        // dict用于指定字体的相关属性的字典，UIKit框架中的第一个头文件
        // context: nil
        
        var nameDict:NSDictionary=[NSFontAttributeName:kNameFont]
        var nameFrame:CGRect=self.status!.name!.textRectWithSize(CGSizeMake(CGFloat.max, CGFloat.max), attributes: nameDict)
        nameFrame.origin.x=CGRectGetMaxX(self.iconF!)+padding
        nameFrame.origin.y=padding+(self.iconF!.size.height-nameFrame.size.height)*0.5
        self.nameF=nameFrame
        // vip 图标
        var vipX:CGFloat=CGRectGetMaxX(self.nameF!)+padding
        var vipY:CGFloat=self.nameF!.origin.y
        var vipW:CGFloat=14
        var vipH:CGFloat=14
        self.vipF=CGRectMake(vipX, vipY, vipW, vipH)
        
        //正文
        var testDict:NSDictionary=[NSFontAttributeName:kTextFont]
        var textFrame:CGRect=self.status!.text!.textRectWithSize(CGSizeMake(300, CGFloat.max), attributes: testDict)
        textFrame.origin.x=padding
        textFrame.origin.y=CGRectGetMaxY(self.iconF!)+padding
        self.textF=textFrame
        
        if let picture=self.status?.picture?.length {
            // 配图
            var pictureX:CGFloat=padding
            var pictureY:CGFloat=CGRectGetMaxY(textFrame)+padding
            var pictureW:CGFloat=100
            var pictureH:CGFloat=100
            self.pictureF=CGRectMake(pictureX, pictureY, pictureW, pictureH)
            self.cellHeight=CGRectGetMaxY(self.pictureF!)+padding
        }else{
            self.cellHeight=CGRectGetMaxY(self.textF!)+padding
        }
        

    }
    
    static func statusFrames()->[WBStatusFrame]{
        let path=NSBundle.mainBundle().pathForResource("statuses", ofType: "plist")
        let dataArray=NSArray(contentsOfFile: path!)
        var statusFrameArray:[WBStatusFrame]=[WBStatusFrame]()
        for dict:AnyObject in dataArray!{
            // 要添加statusFrame对象
            var statusFrame:WBStatusFrame=WBStatusFrame()
            // 实例化一个新的Status模型
            var status:WBStatus=WBStatus(dict: dict as! NSDictionary)
            // 调用自己的setter方法，保存status数据模型，同时计算出所有控件的位置
            statusFrame.setStatus(status)
            // 将statusFrame添加到数组
            statusFrameArray.append(statusFrame)
        }
        return statusFrameArray
    }
    
}