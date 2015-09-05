//
//  CPPushNoticeController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/16.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CPPushNoticeController: CPBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化数据源
        initDataList()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // 初始化数据源
    func initDataList(){
        var dataList=[CPSettingGroup]()
        // 0组
        var group0:CPSettingGroup=CPSettingGroup()
        var item1=CPSettingArrowItem(title: "开奖号码推送", icon: "MorePush",destVcName: "CPScoreNoticeController")
        
        var item2=CPSettingArrowItem(title: "中奖动画", icon: "handShake",destVcName: nil)
        var item3=CPSettingArrowItem(title: "比分直播", icon: "sound_Effect",destVcName: "CPTestViewController")
        var item4=CPSettingArrowItem(title: "购彩定时提醒", icon: "sound_Effect",destVcName: nil)
        
        group0.addSettimgItem(item1)
        group0.addSettimgItem(item2)
        group0.addSettimgItem(item3)
        group0.addSettimgItem(item4)
        dataList.append(group0)
        
        setDataList(dataList)
    }
    
}
