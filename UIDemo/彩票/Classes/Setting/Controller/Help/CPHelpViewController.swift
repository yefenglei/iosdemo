//
//  CPHelpViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/23.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CPHelpViewController: CPBaseTableViewController {

    var htmls:[CPHelp]!
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
        htmls=CPHelp.getHtmls()
        // 0组
        var group0:CPSettingGroup=CPSettingGroup()
        for html:CPHelp in htmls{
            var item=CPSettingArrowItem(title: html.title, icon: nil, destVcName: nil)
            group0.addSettimgItem(item)
        }
        dataList.append(group0)
        
        setDataList(dataList)
    }
    
    // 重写点击事件
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var htmlCtrl=CPHtmlViewController()
        var html=self.htmls[indexPath.row]
        htmlCtrl.html=html
        htmlCtrl.title=html.title
        var navCtrl=CPNavigationViewController(rootViewController: htmlCtrl)
        
        
        self.presentViewController(navCtrl, animated: true, completion: nil)
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
