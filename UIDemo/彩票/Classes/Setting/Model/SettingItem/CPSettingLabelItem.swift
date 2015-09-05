//
//  CPSettingLabelItem.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/17.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CPSettingLabelItem: CPSettingItem {
    private var _label:String?
   //label 显示的内容
    var label:String?{
        get{
            return _label
        }
        set{
            _label=newValue
            CPSaveTool.setObject(title, value: _label)
        }
    }
}
