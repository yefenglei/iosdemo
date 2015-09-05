//
//  CPShareViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/23.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit
import MessageUI

class CPShareViewController: CPBaseTableViewController,MFMessageComposeViewControllerDelegate {

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
        var item1=CPSettingArrowItem(title: "新浪分享", icon: "WeiboSina",destVcName: "CPScoreNoticeController")
        
        var item2=CPSettingArrowItem(title: "短信分享", icon: "SmsShare",destVcName: nil)
        item2.option={[weak self]()->Void in
            var vc:MFMessageComposeViewController=MFMessageComposeViewController()
            vc.body="饭吃了吗?"
            vc.recipients=["10086","10000"]
            vc.messageComposeDelegate=self
            
            var dict:NSDictionary=[NSForegroundColorAttributeName:UIColor.blackColor(),NSFontAttributeName:UIFont.systemFontOfSize(15)]
            vc.navigationBar.titleTextAttributes=dict as [NSObject : AnyObject]
            
            if let strongSelf=self{                
                strongSelf.presentViewController(vc, animated: true, completion: nil)
            }
            
        }
        var item3=CPSettingArrowItem(title: "邮件分享", icon: "MailShare",destVcName: "CPTestViewController")
        
        group0.addSettimgItem(item1)
        group0.addSettimgItem(item2)
        group0.addSettimgItem(item3)
        dataList.append(group0)
        
        setDataList(dataList)
    }

    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    deinit{
        NSLog("share controller被销毁了")
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
