//
//  FLMessageFrameModel.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/6/17.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import Foundation
import UIKit

let bScreenWidth:CGFloat = UIScreen.mainScreen().bounds.size.width

let bScreenHeight:CGFloat = UIScreen.mainScreen().bounds.size.height

let bNormalH:CGFloat = 44

let bIconW:CGFloat = 50

let bIconH:CGFloat = 50

let bBtnFont = UIFont.systemFontOfSize(15)

let bBtnPadding:CGFloat = 20

class FLMessageFrameModel{
    var timeF:CGRect!
    var textViewF:CGRect!
    var iconF:CGRect!
    var cellH:CGFloat!
    var message:FLMessageModel!
    
    init(message:FLMessageModel){
        self.message=message
        
        var padding:CGFloat=10
        // 1.时间
        if(message.hideTime==false){
            var timeX:CGFloat=0
            var timeY:CGFloat=0
            var timeW:CGFloat=bScreenWidth
            var timeH:CGFloat=bNormalH
            
            self.timeF=CGRectMake(timeX, timeY, timeW, timeH)
        }else{
            self.timeF=CGRectMake(0, 0, 0, 0)
        }
        // 2.头像
        var iconX:CGFloat!
        var iconY:CGFloat = CGRectGetMaxY(self.timeF)
        var iconW:CGFloat=bIconW
        var iconH:CGFloat=bIconH
        if(message.type==FLMessageModelType.FLMessageModelGatesby){//自己发的
            iconX=bScreenWidth-iconW-padding
        }else{//别人发的
            iconX=padding
        }
        
        self.iconF=CGRectMake(iconX, iconY, iconW, iconH)
        // 3.正文
        var textX:CGFloat!
        var textY:CGFloat = iconY+padding
        var textMaxSize:CGSize = CGSizeMake(150, CGFloat.max)
        var textDict:NSDictionary = [NSFontAttributeName:bBtnFont]
        var textRealSize:CGRect = message.text.textRectWithSize(textMaxSize, attributes: textDict)
        
        var btnSize=CGSizeMake(textRealSize.width+40, textRealSize.height+40)
        if(message.type==FLMessageModelType.FLMessageModelGatesby){
            textX=bScreenWidth-iconW-padding*2-btnSize.width
        }else{
            textX=padding+iconW
        }
        self.textViewF=CGRectMake(textX, textY, btnSize.width, btnSize.height)
        
        //4.cell高度
        var iconMaxY:CGFloat=CGRectGetMaxY(self.iconF)
        var textMaxY:CGFloat=CGRectGetMaxY(self.textViewF)
        self.cellH = max(iconMaxY, textMaxY)
        
    }
    
    static func messageFrameModels()->[FLMessageFrameModel]{
        let path=NSBundle.mainBundle().pathForResource("messages", ofType: "plist")
        let dataArray=NSArray(contentsOfFile: path!)
        var messageFrameArray=[FLMessageFrameModel]()
        for item:AnyObject in dataArray!{
            var msg:FLMessageModel=FLMessageModel(dict: item as! NSDictionary)
            var lastFM:FLMessageFrameModel?=messageFrameArray.last
            if(lastFM != nil){
                // 隐藏时间
                if(lastFM!.message.time==msg.time){
                    msg.hideTime=true
                }else{
                    msg.hideTime=false
                }
            }
            messageFrameArray.append(FLMessageFrameModel(message: msg))
        }
        return messageFrameArray
    }

}