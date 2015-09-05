//
//  CPProductData.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/16.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

/*
{
"title": "网易公开课",
"id": "com.netease.videoHD",
"url": "http://itunes.apple.com/app/id415424368?mt=8",
"icon": "open@2x.png",
"customUrl": "ntesopen"
}
*/

import Foundation
class CPProduct {
    var title:String!
    var id:String!
    var url:String!
    var icon:String!
    var customUrl:String!
    
    init(dict:NSDictionary){
        self.title=dict.valueForKey("title") as! String
        self.id=dict.valueForKey("id") as! String
        self.url=dict.valueForKey("url") as! String
        self.icon=dict.valueForKey("icon") as! String
        self.customUrl=dict.valueForKey("customUrl") as! String
    }
    
    static func getProducts()->[CPProduct]{
        var products:[CPProduct]=[CPProduct]()
        var filepath=NSBundle.mainBundle().pathForResource("products", ofType: "json")
        var jsonData:NSData?
        if let file=filepath{
            jsonData=NSData(contentsOfFile: file)
            var jsonArray:[NSDictionary]?=NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableLeaves, error: nil) as? [NSDictionary]
            if(jsonArray != nil){
                for dict:NSDictionary in jsonArray!{
                    products.append(CPProduct(dict: dict))
                }
            }
        }
        return products
    }
}