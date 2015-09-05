//
//  CPSettingGroup.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/9.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import Foundation

class CPSettingGroup{
    var header:String?
    var footer:String?
    lazy var settingItems:[CPSettingItem]=[CPSettingItem]()
    
    init(){
        
    }
    
    init(settingItems:[CPSettingItem],header:String,footer:String){
        self.settingItems=settingItems
        self.header=header
        self.footer=footer
    }
    
    func addSettimgItem(item:CPSettingItem){
        settingItems.append(item)
    }
}