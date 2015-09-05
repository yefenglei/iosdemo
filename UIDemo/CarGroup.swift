//
//  CarGroup.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/6/8.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import Foundation
class CarGroup {
    var title:String=String()
    var cars:NSMutableArray=NSMutableArray()
    init(dict:NSDictionary){
        self.cars=Car.carsWithArray(dict.valueForKey("cars") as! NSArray)
        self.title=dict.valueForKey("title") as! String
    }
    static func carGroupWithDict(dict:NSDictionary)->CarGroup{
        return CarGroup(dict: dict)
    }
    static func carGroups()->NSMutableArray{
        let path=NSBundle.mainBundle().pathForResource("cars_total", ofType: "plist")
        let dataArray=NSArray(contentsOfFile: path!)
        var arrayM:NSMutableArray=NSMutableArray()
        for dict:AnyObject in dataArray!{
            arrayM.addObject(carGroupWithDict(dict as! NSDictionary))
        }
        return arrayM
    }
    
    func description()->String{
        return "\(self)  title:\(self.title)  cars:\(self.cars)"
    }
}