//
//  WBViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/6/14.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class WBViewController: UITableViewController {

    let ID:String="Cell"
    lazy var statusFrames:[WBStatusFrame]=WBStatusFrame.statusFrames()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 为tableView注册可重用单元格
        self.tableView.registerClass(WBStatusCell.self, forCellReuseIdentifier: ID)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return self.statusFrames.count;
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {


        // Configure the cell...
        
        /**
        在Storyboard中指定了可重用标示符，同时指定了Cell的类是HMStatusCell
        
        系统会为tableView注册一个原形Cell，专门用来做可重用单元格的，一旦缓冲区中不存在
        可重用单元格，系统会使用原形Cell新实例化一个Cell用程序使用！
        
        因此如果在，Storyboard中，注册了原形Cell，就不再需要 cell == nil的判断了
        */
        //    HMStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        // unable to dequeue a cell with identifier Cell - must register a nib or a class for the identifier or connect a prototype cell in a storyboard
        // 使用这个方法，要求一定注册可重用单元格，否则就会崩溃！
        // 官方建议使用以下方法，利用程序的崩溃，及时发现问题
        let cell = tableView.dequeueReusableCellWithIdentifier(ID, forIndexPath: indexPath) as! WBStatusCell
        let statusFrame=self.statusFrames[indexPath.row]
        cell.setStatusFrame(statusFrame)
        
        return cell
    }
    
    /** 计算单元格行高 */
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        /**
        计算行高的方法，会在加载表格数据时，有多少行计算多少次 contentSize
        
        问题：此方法执行的时候，cell还没有被实例化！
        但是：行高计算是在实例化cell时，通过设置status属性，计算的=>有了status模型，就可以知道行高！
        
        问题：如何在cell实例化之前，获得行高？
        解决方法：通过status可以计算得到行高！=》再建立一个模型，专门计算所有控件的位置
        */
        var statusFrame:WBStatusFrame=self.statusFrames[indexPath.row]
        return statusFrame.cellHeight!
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
