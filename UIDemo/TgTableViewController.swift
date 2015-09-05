//
//  TgTableViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/6/11.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class TgTableViewController: UITableViewController,MyTgFootViewDelegate {

    var tgs:[MyTg]!
    var footer:MyTgFootView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tgs=MyTg.tgs()
        self.tableView.rowHeight=64
        self.tableView.contentInset=UIEdgeInsetsMake(20, 0, 0, 0)
        footer=MyTgFootView.footerview()
        self.tableView.tableFooterView=footer
        footer.delegate=self

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func tgFooterViewDidDownloadButtonClick(tgFootView: MyTgFootView) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(2 * NSEC_PER_SEC)),dispatch_get_main_queue(),{
            ()-> Void in
            //加载数据,使用代理
            NSLog("努力加载数据中......")
            var dict:NSDictionary = ["title" : "新增数据","icon":"ad_00","price":"998","buyCount":"15"]
        
            var tg=MyTg.tgWithDict(dict)
            self.tgs.append(tg)
            //刷新数据
            var path:NSIndexPath=NSIndexPath(forRow: self.tgs.count-1, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([path], withRowAnimation: UITableViewRowAnimation.Automatic)
            tgFootView.endRefresh()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.tgs.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 1.创建cell
        var cell=MyCell.cellWithTableView(tableView)
        // 2. 通过数据模型，设置cell内容，可以让视图控制器不需要了解cell内部的实现细节
        cell.setTg(self.tgs[indexPath.row])
        return cell
    }
    /**/

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
