//
//  FLMessageModel.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/6/17.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import Foundation
enum FLMessageModelType:Int{
    case FLMessageModelGatesby = 0 , FLMessageModelJobs
}
class FLMessageModel:NSObject{
    var text:NSString!
    var time:String!
    var type:FLMessageModelType!
    var hideTime:Bool!=false
    override init(){
        super.init()
    }
    
    init(dict:NSDictionary){
        super.init()
        self.text=dict.valueForKey("text") as? NSString
        self.time=dict.valueForKey("time") as? String
        var tNum = dict.valueForKey("type") as? NSNumber
        self.type=FLMessageModelType(rawValue: tNum!.integerValue)
    }
}