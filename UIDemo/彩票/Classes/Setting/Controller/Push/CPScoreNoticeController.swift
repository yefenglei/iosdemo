//
//  CPScoreNoticeController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/17.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CPScoreNoticeController: CPBaseTableViewController {
    
    var _startTime:CPSettingLabelItem!
    var _endTime:CPSettingLabelItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initDataList()
        
        // Do any additional setup after loading the view.
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
        var matchNotice=CPSettingSwitchItem(title: "提醒我关注比赛", icon: nil)
        group0.header="头头头"
        group0.footer="脚脚脚"
        group0.addSettimgItem(matchNotice)
        
        // 1组
        var group1:CPSettingGroup=CPSettingGroup()
        group1.header=""
        group1.footer=""
        _startTime=CPSettingLabelItem(title: "开始时间", icon: nil)
        var startTimeText=CPSaveTool.objectForKey(_startTime.title) as? String
        if(startTimeText == nil){
            _startTime.label="00:00"
        }else{
            _startTime.label=startTimeText!
        }

        _startTime.option={()->Void in
            var textField=UITextField()
            var datePicker=UIDatePicker()
            // 设置模式
            datePicker.datePickerMode=UIDatePickerMode.Time
            // 设置地区
            datePicker.locale=NSLocale(localeIdentifier: "zh")
            // 设置格式
            var dateFormatter=NSDateFormatter()
            dateFormatter.dateFormat="HH:mm"
            
            datePicker.date=dateFormatter.dateFromString("00:00")!
            datePicker.addTarget(self, action: "startTimeChanged:", forControlEvents: UIControlEvents.ValueChanged)
            // 设置键盘
            textField.inputView=datePicker
            
            self.view.addSubview(textField)
            textField.becomeFirstResponder()
        }
        group1.addSettimgItem(_startTime)
        // 2组
        var group2:CPSettingGroup=CPSettingGroup()
        _endTime=CPSettingLabelItem(title: "结束时间", icon: nil)
        var endTimeText=CPSaveTool.objectForKey(_endTime.title) as? String
        if(endTimeText == nil){
            _endTime.label="00:00"
        }else{
            _endTime.label=endTimeText!
        }
        _endTime.option={()->Void in
            var textField=UITextField()
            var datePicker=UIDatePicker()
            // 设置模式
            datePicker.datePickerMode=UIDatePickerMode.Time
            // 设置地区
            datePicker.locale=NSLocale(localeIdentifier: "zh")
            // 设置格式
            var dateFormatter=NSDateFormatter()
            dateFormatter.dateFormat="HH:mm"
            
            datePicker.date=dateFormatter.dateFromString("00:00")!
            datePicker.addTarget(self, action: "endTimeChanged:", forControlEvents: UIControlEvents.ValueChanged)
            // 设置键盘
            textField.inputView=datePicker
            
            self.view.addSubview(textField)
            textField.becomeFirstResponder()
        }
        group2.addSettimgItem(_endTime)

    
        dataList.append(group0)
        dataList.append(group1)
        dataList.append(group2)
        setDataList(dataList)
    }
    
    func startTimeChanged(datePicker:UIDatePicker){
        // 创建日期格式对象
        var dateF=NSDateFormatter()
        dateF.dateFormat="HH:mm"
        _startTime.label=dateF.stringFromDate(datePicker.date)
        self.tableView.reloadData()
    }
    
    func endTimeChanged(datePicker:UIDatePicker){
        // 创建日期格式对象
        var dateF=NSDateFormatter()
        dateF.dateFormat="HH:mm"
        _endTime.label=dateF.stringFromDate(datePicker.date)
        self.tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
