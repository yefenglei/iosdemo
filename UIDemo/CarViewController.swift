//
//  CarViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/6/8.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit
class CarViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var id:String = "Cell"
    var tblView:UITableView!
    var carGroups:NSMutableArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        carGroups=CarGroup.carGroups()
        tblView=UITableView(frame: CGRectMake(0, 20, self.view.bounds.width, self.view.bounds.height-20), style: UITableViewStyle.Plain)
        tblView.dataSource=self
        tblView.delegate=self
        
        self.view.addSubview(tblView)
        //NSLog("%@", carGroups)

        // Do any additional setup after loading the view.
        //开启编辑模式，可以用于删除数据
        self.tblView.editing=true
    }
    
    //返回编辑样式
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if(indexPath.row % 2==0){
            return UITableViewCellEditingStyle.Insert
        }
        else{
            return UITableViewCellEditingStyle.Delete
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //隐藏状态栏
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.carGroups.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var group:CarGroup = self.carGroups[section] as! CarGroup
        return group.cars.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell?=self.tblView.dequeueReusableCellWithIdentifier(id) as? UITableViewCell
        if(cell==nil){
            cell=UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: id)
        }
        //设置cell内容
        var group:CarGroup=self.carGroups[indexPath.section] as! CarGroup
        var car:Car=group.cars[indexPath.row] as! Car
        cell?.imageView?.image=UIImage(named: car.icon)
        cell!.textLabel?.text=car.name
        return cell!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var group:CarGroup=carGroups[section] as! CarGroup
        return group.title
    }
    
    //右侧索引
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
        var indexList:[String]=[String]()
        for group:AnyObject in carGroups {
            let t=(group as! CarGroup).title
            indexList.append(t)
        }
        return indexList
        //return self.carGroups.valueForKey("title")
    }
    //滑动删除
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle==UITableViewCellEditingStyle.Delete){
            NSLog("点击删除%@", indexPath)
            var carGroup=self.carGroups[indexPath.section] as! CarGroup
            carGroup.cars.removeObjectAtIndex(indexPath.row)
            tblView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }else if(editingStyle==UITableViewCellEditingStyle.Insert){
            NSLog("点击添加%@", indexPath)
            var carGroup=self.carGroups[indexPath.section] as! CarGroup
            var data:Dictionary<String,String>=Dictionary<String,String>()
            data["name"]="奥拓"
            data["icon"]="m_180_100.png"
            carGroup.cars.insertObject(Car(dict: data), atIndex: indexPath.row+1)
            var path:NSIndexPath=NSIndexPath(forRow: indexPath.row+1, inSection: indexPath.section)
            tblView.insertRowsAtIndexPaths([path], withRowAnimation: UITableViewRowAnimation.Automatic )
            
        }
    }
    //移动表格行
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        var sourceCarGroup=self.carGroups[sourceIndexPath.section] as! CarGroup
        var destinationCarGroup=self.carGroups[destinationIndexPath.section] as! CarGroup
        var sourceCar=sourceCarGroup.cars[sourceIndexPath.row] as! Car
        var destinationCar=destinationCarGroup.cars[destinationIndexPath.row] as! Car
        //sourceCarGroup.cars.removeObjectAtIndex(sourceIndexPath.row)
        //destinationCarGroup.cars.removeObjectAtIndex(destinationIndexPath.row)
        
        sourceCarGroup.cars[sourceIndexPath.row]=destinationCar
        
        destinationCarGroup.cars[destinationIndexPath.row]=sourceCar

        tblView.reloadData()
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
