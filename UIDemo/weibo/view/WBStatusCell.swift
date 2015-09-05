//
//  WBStatusCell.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/6/14.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class WBStatusCell: UITableViewCell {

    var iconView:UIImageView!
    var nameView:UILabel!
    var vipView:UIImageView!
    var textView:UILabel!
    var pictureView:UIImageView!
    private var statusFrame:WBStatusFrame!
    /** 姓名字体 */
    let kNameFont=UIFont.systemFontOfSize(14)
    /** 正文字体 */
    let kTextFont=UIFont.systemFontOfSize(16)
    var isNeedInitialize:Bool=true

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }
    //初始化控件
    func initCtrl(){
        self.iconView=UIImageView()
        
        self.nameView=UILabel()
        self.nameView.font=kNameFont
        
        self.vipView=UIImageView()
        self.vipView.image=UIImage(named: "vip")
        self.vipView.hidden=true
        
        self.textView=UILabel()
        self.textView.font=kTextFont
        self.textView.numberOfLines=0
        self.pictureView=UIImageView()
        
        self.contentView.addSubview(self.iconView)
        self.contentView.addSubview(self.nameView)
        self.contentView.addSubview(self.vipView)
        self.contentView.addSubview(self.textView)
        self.contentView.addSubview(self.pictureView!)
        
        self.isNeedInitialize=false
    }
    
    func setStatusFrame(status_frame:WBStatusFrame){
        self.statusFrame = status_frame
        if(self.isNeedInitialize){
            self.initCtrl()
        }
        
        // 1> 设置数据
        self.settingData()
        // 2> 设置位置
        self.settingFrame()
    }
    
    /** 设置数据 */
    func settingData(){
        var status:WBStatus=self.statusFrame.status!
        // 头像
        self.iconView.image=UIImage(named: status.icon! as String)
        // 姓名
        self.nameView.text = status.name as? String
        // vip(可选的)
        if(status.vip!.intValue==1){
            self.vipView.hidden=false
            self.nameView.textColor=UIColor.redColor()
        }else{
            self.vipView.hidden=true
            self.nameView.textColor=UIColor.blackColor()
        }
        // 正文
        self.textView.text=status.text as? String
        
        //配图（可选参数）
        if let picture=status.picture{
            self.pictureView.hidden=false
            self.pictureView.image=UIImage(named: (status.picture as? String)!)
        }else{
            self.pictureView.hidden=true
        }
    }
    
    /** 设置位置 */
    func settingFrame(){
        // 1.头像
        self.iconView.frame=self.statusFrame.iconF!
        // 2.姓名大小由文字的长度来决定
        self.nameView.frame=self.statusFrame.nameF!
        // vip图标
        self.vipView.frame=self.statusFrame.vipF!
        //正文
        self.textView.frame=self.statusFrame.textF!
        //配图
        if let picture=self.statusFrame.status?.picture{
            self.pictureView.frame=self.statusFrame.pictureF!
        }
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
