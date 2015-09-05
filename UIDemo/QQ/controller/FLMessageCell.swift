//
//  FLMessageCell.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/6/17.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class FLMessageCell: UITableViewCell {

    var time:UILabel!
    var textView:UIButton!
    var icon:UIImageView!
    var isNeedInitialize:Bool=true
    var frameModel:FLMessageFrameModel!
    //初始化控件
    func initCtrl(){
        // 1.时间
        self.time=UILabel()
        time.textAlignment=NSTextAlignment.Center
        time.font=UIFont.systemFontOfSize(13.0)
        self.contentView.addSubview(time)
        // 2.正文
        self.textView=UIButton()
        self.textView.titleLabel?.font=bBtnFont
        self.textView.titleLabel?.numberOfLines=0;//自动换行
        self.textView.contentEdgeInsets=UIEdgeInsetsMake(20, 20, 20, 20)
        self.textView.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.contentView.addSubview(self.textView)
        //3.头像
        self.icon=UIImageView()
        self.contentView.addSubview(self.icon)
        
        self.backgroundColor=UIColor.clearColor()
    }
    
    // 设置内容和frame
    func setFrameMessage(frameModel:FLMessageFrameModel){
        if(isNeedInitialize){
            initCtrl()
            isNeedInitialize=false
        }
        self.frameModel=frameModel
        // 1.时间
        var model:FLMessageModel=self.frameModel.message
        self.time.text=model.time
        self.time.frame=self.frameModel.timeF
        // 2.头像
        self.icon.frame=self.frameModel.iconF
        if(model.type==FLMessageModelType.FLMessageModelGatesby){
            self.icon.image=UIImage(named: "Gatsby")
        }else{
            self.icon.image=UIImage(named: "Jobs")
        }
        // 3.正文
        self.textView.frame=self.frameModel.textViewF
        self.textView.setTitle(model.text as String, forState: UIControlState.Normal)
        
        if(model.type==FLMessageModelType.FLMessageModelGatesby){
            self.textView.setBackgroundImage(UIImage.resizeWithImageName("chat_send_nor"), forState: UIControlState.Normal)
        }
        else{
            self.textView.setBackgroundImage(UIImage.resizeWithImageName("chat_recive_nor"), forState: UIControlState.Normal)
        }
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
