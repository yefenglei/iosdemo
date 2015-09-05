//
//  FLNetworkTool.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/7/23.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import Foundation
class FLNetworkTool{
    static func isEnable3G()->Bool{
        // 1.获取reachability对象
        var wifi:Reachability=Reachability.reachabilityForInternetConnection()
        // 2.获得Reachability对象的当前网络状态
        var wifiStatus=wifi.currentReachabilityStatus()
        
        if(wifiStatus.value != NotReachable.value){
            return true
        }else{
            return false
        }
    }
    
    static func isEnableWifi()->Bool{
        // 1.获取reachability对象
        var wifi:Reachability=Reachability.reachabilityForLocalWiFi()
        // 2.获得Reachability对象的当前网络状态
        var wifiStatus=wifi.currentReachabilityStatus()
        
        return (wifiStatus.value != NotReachable.value)
    }
}