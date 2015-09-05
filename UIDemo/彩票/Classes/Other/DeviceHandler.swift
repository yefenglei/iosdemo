//
//  DeviceHandler.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/8.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import Foundation

class DeviceHandler{
    static var IsGtIOS7:Bool{
        get{
            return (NSString(string: UIDevice.currentDevice().systemVersion).doubleValue >= 7.0)
        }
    }
}