//
//  CPAboutViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/23.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CPAboutViewController: CPBaseTableViewController {
    lazy var webview=UIWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        initDataList()
        
        self.tableView.tableHeaderView=CPAboutHeaderView.HeaderView()

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
        var item1=CPSettingArrowItem(title: "评分支持", icon: nil,destVcName: nil)
        item1.option={()->Void in
            var appid="635768442"
            var urlStr="itms-apps://itunes.apple.com/cn/app/id\(appid)?mt=8"
            UIApplication.sharedApplication().openURL(NSURL(string: urlStr)!)
        }
        
        var item2=CPSettingArrowItem(title: "客服电话", icon: nil,destVcName: nil)
        item2.subTitle="020-88419165"
        item2.option={()->Void in
            //var url=NSURL(string:"tel://15088931669")!
            //var url=NSURL(string:"telprompt://15088931669")!  //私有api,审核不通过
            //UIApplication.sharedApplication().openURL(url)
            

            self.webview.loadRequest(NSURLRequest(URL: NSURL(string: "tel://10086")!))
        }
        
        group0.addSettimgItem(item1)
        group0.addSettimgItem(item2)
        dataList.append(group0)
        
        setDataList(dataList)
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
