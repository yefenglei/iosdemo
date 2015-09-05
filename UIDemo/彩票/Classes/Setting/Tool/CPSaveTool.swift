//
//  CPSaveTool.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/18.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import Foundation
class CPSaveTool{
    static func setObject(key:String,value:AnyObject?){
        NSUserDefaults.standardUserDefaults().setObject(value, forKey: key)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    static func objectForKey(key:String)->AnyObject?{
        return NSUserDefaults.standardUserDefaults().valueForKey(key)
    }
}