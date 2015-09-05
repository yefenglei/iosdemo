//
//  SettingData.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/9.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import Foundation

class CPSettingData{
    static private var _dataList:[CPSettingGroup]?
    static var dataList:[CPSettingGroup]{
        get{
            if(_dataList == nil){
                _dataList=[CPSettingGroup]()
                // 0组
                var group0:CPSettingGroup=CPSettingGroup()
                var item1=CPSettingArrowItem(title: "推送与提醒", icon: "MorePush",destVcName: "CPPushNoticeController")

                var item2=CPSettingSwitchItem(title: "摇一摇随机选", icon: "handShake")
                group0.addSettimgItem(item1)
                group0.addSettimgItem(item2)
                group0.header=""
                //group0.footer="我是脚部"
                // 1组
                var group1:CPSettingGroup=CPSettingGroup()
                var item3=CPSettingItem(title: "检查新版本", icon: "MoreUpdate")
                // 保存检查更新的功能
                item3.option={()->Void in
                    // 1.现实蒙板
                    MBProgressHUD.showMessage("正在检查...")
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(500 * NSEC_PER_MSEC)), dispatch_get_main_queue(), { () -> Void in
                        // 隐藏蒙板
                        MBProgressHUD.hideHUD()
                        var alert:UIAlertView = UIAlertView(title: "有更新版本", message: "version 2.2", delegate: nil, cancelButtonTitle: "取消", otherButtonTitles: "立即更新")
                        alert.show()
                        
                    })
                }
                var item4=CPSettingArrowItem(title: "帮助", icon: "MoreHelp",destVcName: "CPHelpViewController")
                var item5=CPSettingArrowItem(title: "分享", icon: "MoreShare",destVcName: "CPShareViewController")
                var item6=CPSettingArrowItem(title: "产品推荐", icon: "MoreNetease",destVcName: "CPProductCollectionViewController")
                var item7=CPSettingArrowItem(title: "关于", icon: "MoreNetease",destVcName: "CPAboutViewController")
                
                group1.addSettimgItem(item3)
                group1.addSettimgItem(item4)
                group1.addSettimgItem(item5)
                group1.addSettimgItem(item6)
                group1.addSettimgItem(item7)
                group1.header=""
                //group1.footer="我是脚部2"
                
                _dataList!.append(group0)
                _dataList!.append(group1)
                return _dataList!
            }
            return _dataList!
        }
    }
    
    
}