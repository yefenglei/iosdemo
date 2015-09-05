//
//  HelpModel.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/23.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import Foundation
class CPHelp{
    var title:String!
    var id:String?
    var html:String!
    
    init(dict:NSDictionary){
        self.title=dict.valueForKey("title") as! String
        self.id=dict.valueForKey("id") as? String
        self.html=dict.valueForKey("html") as! String
    }
    
    static func getHtmls()->[CPHelp]{
        var htmls:[CPHelp]=[CPHelp]()
        var filepath=NSBundle.mainBundle().pathForResource("help", ofType: "json")
        var jsonData:NSData?
        if let file=filepath{
            jsonData=NSData(contentsOfFile: file)
            var jsonArray:[NSDictionary]?=NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableLeaves, error: nil) as? [NSDictionary]
            if(jsonArray != nil){
                for dict:NSDictionary in jsonArray!{
                    htmls.append(CPHelp(dict: dict))
                }
            }
        }
        return htmls
    }
}