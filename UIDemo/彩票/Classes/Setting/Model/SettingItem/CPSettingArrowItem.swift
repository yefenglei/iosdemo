//
//  CPSettingArrowItem.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/9.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CPSettingArrowItem: CPSettingItem {
    var destVcName:String?
    init(title: String, icon: String?,destVcName:String?){
        super.init(title: title, icon: icon)
        self.destVcName=destVcName
    }
}
