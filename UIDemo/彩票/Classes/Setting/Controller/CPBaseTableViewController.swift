//
//  CPBaseTableViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/17.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CPBaseTableViewController: UITableViewController {

    private var _dataList:[CPSettingGroup]!
    
    init(){
        super.init(style: UITableViewStyle.Grouped)
    }
    
    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override init!(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset=UIEdgeInsetsMake(15, 0, 0, 0)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return self._dataList.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self._dataList[section].settingItems.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell=CPSettingCell.cellWithTableView(tableView)
        var settingItem=self._dataList[indexPath.section].settingItems[indexPath.row]
        cell.setItem(settingItem)
        return cell
    }
    
    // 设置group的头部信息
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self._dataList[section].header
    }
    // 设置group的脚部信息
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self._dataList[section].footer
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // 取消选中
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        // 取出模型
        var cell=self._dataList[indexPath.section].settingItems[indexPath.row]
        // 执行操作
        if(cell.option != nil){
            cell.option!();
            return
        }
        
        var arrowCell=cell as? CPSettingArrowItem
        if(arrowCell != nil && arrowCell!.destVcName != nil){
            var vcType=swiftClassFromString(arrowCell!.destVcName!) as! UIViewController.Type
            var vc = vcType()
            vc.title=arrowCell?.title
            self.navigationController?.showViewController(vc, sender: self)
        }
        
    }
    
    
    
    // 设置数据源
    func setDataList(dataList:[CPSettingGroup]){
        _dataList=dataList
    }
    
    func addGroupToDataList(group:CPSettingGroup){
        _dataList.append(group)
    }
    
    
    func swiftClassFromString(className: String) -> AnyClass! {
        // get the project name
        if  var appName = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as? String {
            // generate the full name of your class (take a look into your "YourProject-swift.h" file)
            let classStringName = "_TtC\(count(appName))\(appName)\(count(className))\(className)"
            // return the class!
            return NSClassFromString(classStringName)
        }
        return nil;
    }
}
