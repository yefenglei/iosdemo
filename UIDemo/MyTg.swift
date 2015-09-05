//
//  MyTg.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/6/11.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import Foundation
class MyTg{
    var title:String?
    var icon:String?
    var price:String?
    var buyCount:String?
    
    init(dict:NSDictionary){
        self.title=dict.valueForKey("title") as? String
        self.icon=dict.valueForKey("icon") as? String
        self.price=dict.valueForKey("price") as? String
        self.buyCount=dict.valueForKey("buyCount") as? String
    }
    
    static func tgWithDict(dict:NSDictionary)->MyTg{
        return MyTg(dict: dict)
    }
    
    static func tgs()->[MyTg]{
        let path=NSBundle.mainBundle().pathForResource("tgs", ofType: "plist")
        let dataArray=NSArray(contentsOfFile: path!)
        var tgArray:[MyTg]=[MyTg]()
        for dict:AnyObject in dataArray!{
            tgArray.append(tgWithDict(dict as! NSDictionary))
        }
        return tgArray
    }
}