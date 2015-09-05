//
//  CPSettingCell.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/9.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CPSettingCell: UITableViewCell {
    var _item:CPSettingItem!
    lazy var switchView:UISwitch=UISwitch()
    lazy var imgView:UIImageView = UIImageView(image: UIImage(named: "CellArrow"))
    private var _labelView:UILabel?
    var lbView:UILabel{
        get{
            if(_labelView == nil){
                _labelView=UILabel(frame: CGRectMake(0, 0, 100, 44))
                _labelView!.textColor=UIColor.redColor()
                _labelView!.textAlignment=NSTextAlignment.Right
                return _labelView!
            }else{
                return _labelView!
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setItem(item:CPSettingItem){
        // 1.设置子控件的数据
        setUpData(item);
        // 2.设置右边视图
        setAccessoryView();
    }
    
    
    
    // 设置子控件的数据
    func setUpData(item:CPSettingItem){
        self._item=item
        if(item.icon != nil){
            self.imageView?.image=UIImage(named: item.icon!)
        }
        self.textLabel?.text=item.title
        self.detailTextLabel?.text=item.subTitle


    }
    
    // 设置右边视图
    func setAccessoryView(){
        if(self._item.isKindOfClass(CPSettingArrowItem)){ // 箭头
            self.accessoryView=self.imgView
            self.selectionStyle=UITableViewCellSelectionStyle.Default
        }else if(self._item.isKindOfClass(CPSettingSwitchItem)){ // switch
            self.accessoryView=self.switchView
            self.selectionStyle=UITableViewCellSelectionStyle.None
        }else if(self._item.isKindOfClass(CPSettingLabelItem)){
            //initLabel();
            var labelItem=self._item as! CPSettingLabelItem
            self.lbView.text=labelItem.label
            self.accessoryView=self.lbView
            self.selectionStyle=UITableViewCellSelectionStyle.Default
        }else{
            self.accessoryView=nil
            self.selectionStyle=UITableViewCellSelectionStyle.Default
        }
    }
    
    static func cellWithTableView(tableview:UITableView)->CPSettingCell{
        let ID:String="cell"
        var cell = tableview.dequeueReusableCellWithIdentifier(ID) as? CPSettingCell
        // Configure the cell...
        if(cell == nil){
            cell=CPSettingCell(style: UITableViewCellStyle.Value1, reuseIdentifier: ID)
            tableview.registerClass(CPSettingCell.self, forCellReuseIdentifier: ID)
        }
        return cell!
    }
}
