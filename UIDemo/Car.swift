//
//  Car.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/6/8.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import Foundation
class Car{
    var name:String=String()
    var icon:String=String()
    init(dict:NSDictionary){
        name = dict.valueForKey("name") as! String
        icon = dict.valueForKey("icon") as! String
    }
    static func carWithDict(dict:NSDictionary)->Car{
        return Car(dict: dict)
    }
    static func carsWithArray(dataArray:NSArray)->NSMutableArray{
        var arrayM:NSMutableArray=NSMutableArray()
        for dict:AnyObject in dataArray{
            arrayM.addObject(carWithDict(dict as! NSDictionary))
        }
        return arrayM
    }
}