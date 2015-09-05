//
//  SettingModel.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/9.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import Foundation

//enum CPSettingItemType:Int{
//    case CPSettingItemTypeNormal=0,CPSettingItemTypeArrow,CPSettingItemTypeSwitch
//}
typealias SettingItemOption=()->Void

class CPSettingItem:NSObject{
    var title:String
    var icon:String?
    var option:SettingItemOption?
    var subTitle:String?
    //var type:CPSettingItemType
    init(title:String,icon:String?){
        self.title=title
        self.icon=icon
        //self.type=CPSettingItemType.CPSettingItemTypeNormal
    }
}