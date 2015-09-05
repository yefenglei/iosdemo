//
//  FLContact.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/6/27.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import Foundation

let FLNameKey:String="name"
let FLPhoneKey:String="phone"
class FLContact:NSObject,NSCoding{
    var name:String!
    var phone:String!
    init(name:String,phone:String){
        self.name=name
        self.phone=phone
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: FLNameKey)
        aCoder.encodeObject(phone, forKey: FLPhoneKey)
    }

    required init(coder aDecoder: NSCoder) {
        super.init()
        name=aDecoder.decodeObjectForKey(FLNameKey) as! String
        phone=aDecoder.decodeObjectForKey(FLPhoneKey) as! String
    }
}