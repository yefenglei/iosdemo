//
//  WBStatus.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/6/14.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import Foundation

class WBStatus:NSObject{
    var name:NSString?
    var icon:NSString?
    var text:NSString?
    var picture:NSString?
    var vip:NSNumber?
    
    
    init(dict:NSDictionary){
        super.init()
        self.setValuesForKeysWithDictionary(dict as [NSObject : AnyObject])
        
//        self.name=dict.valueForKey("name") as? NSString
//        self.icon=dict.valueForKey("icon") as? NSString
//        self.text=dict.valueForKey("text") as? NSString
//        self.picture=dict.valueForKey("picture") as? NSString
//        self.vip=dict.valueForKey("vip") as? NSNumber
    }
}