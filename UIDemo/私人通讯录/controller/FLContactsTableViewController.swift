//
//  FLContactsTableViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/6/27.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class FLContactsTableViewController: UITableViewController ,UIActionSheetDelegate,FLAddViewControllerDelegate,FLEditViewControllerDelegate{
    
    // 获取Documents文件夹路劲
    // 拼接文件名
    var filePath:NSString=NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0].stringByAppendingPathComponent("contact.data")
    
    var contacts:[FLContact]=[FLContact]()
    var currentIndex:NSIndexPath?
    // 点击注销会调用这个方法
    @IBAction func logout(sender: UIBarButtonItem) {
        var sheet:UIActionSheet=UIActionSheet(title: "是否注销", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: "注销")
        sheet.showInView(self.view)
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if(buttonIndex==0){//确定注销
            self.navigationController?.popViewControllerAnimated(true)
        }else{
            return
        }
    }

    // MARK: 视图初始化
    override func viewDidLoad() {
        super.viewDidLoad()
        //NSLog("%@", filePath)
        // 解档contacts数据
        if(contacts.count==0){
            var contactList=NSKeyedUnarchiver.unarchiveObjectWithFile(filePath as String) as? [FLContact]
            if (contactList != nil){
                contacts=contactList!
            }
        }
        
        // 移除分割线
        self.tableView.separatorStyle=UITableViewCellSeparatorStyle.None
        
        // 获取+按钮
        var add:UIBarButtonItem=self.navigationItem.rightBarButtonItem!
        
        // 添加一个垃圾桶按钮
        var trash:UIBarButtonItem=UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: "deleteContact")
        self.navigationItem.rightBarButtonItems=[add,trash]
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func deleteContact(){
        self.tableView.setEditing(!self.tableView.editing, animated: true)
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
        return contacts.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // 如果是新增联系人
        var vc:FLAddViewController?=segue.destinationViewController as? FLAddViewController
        if(vc != nil){
            vc!.delegate=self
        }
        // 如果是编辑联系人
        var vcEdit:FLEditViewController?=segue.destinationViewController as? FLEditViewController
        if(vcEdit != nil){
            vcEdit!.delegate=self
            vcEdit!.name=contacts[currentIndex!.row].name
            vcEdit!.phone=contacts[currentIndex!.row].phone
            
        }
    }
    // 成功添加一个联系人
    func addViewController(add: FLAddViewController, contact: FLContact) {
        // 添加到表格数据源
        contacts.append(contact)
        // 刷新表格
        self.tableView.reloadData()
        //NSLog("%@", contact.name)
        

        
        // 归档
        NSKeyedArchiver.archiveRootObject(self.contacts, toFile: filePath as String)
    }
    // 成功编辑一个联系人
    func EditViewController(sender: FLEditViewController, contact: FLContact) {
        // 更新到表格数据源
        contacts[currentIndex!.row].name=contact.name
        contacts[currentIndex!.row].phone=contact.phone
        // 刷新表格
        //self.tableView.reloadData()
        // 局部刷新
        self.tableView.reloadRowsAtIndexPaths([currentIndex!], withRowAnimation: UITableViewRowAnimation.Automatic)
        //NSLog("%@", contact.name)
        // 归档
        NSKeyedArchiver.archiveRootObject(self.contacts, toFile: filePath as String)
    }
    
    // 滑动删除
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle==UITableViewCellEditingStyle.Delete){//删除
            // 更新数据
            self.contacts.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        currentIndex=NSIndexPath(forRow: indexPath.row, inSection: indexPath.section)
        self.performSegueWithIdentifier("contact2edit", sender: nil)
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let ID:String="contact"
        let cell = tableView.dequeueReusableCellWithIdentifier(ID, forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        var contact:FLContact=contacts[indexPath.row]
        cell.textLabel?.text=contact.name
        cell.detailTextLabel?.text=contact.phone

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
