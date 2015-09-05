//
//  CPTabBar.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/1.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

typealias tabBarClick=(selectedIndex:Int)->Void

protocol tabBarDelegate:NSObjectProtocol{
    func tabBar(didSelectedIndex:Int)
}

class CPTabBar: UIView {

    var tabBarClickBlock=tabBarClick?()
    weak var delegate:tabBarDelegate?
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame=frame
        //addBtns()
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addBtns(){
        for i:Int in 1...5{
            var btn:UIButton=UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
            btn.tag = i-1
            // 设置按钮图片
            btn.setBackgroundImage(UIImage(named: "TabBar\(i)"), forState: UIControlState.Normal)
            btn.setBackgroundImage(UIImage(named: "TabBar\(i)Sel"), forState: UIControlState.Selected)
            btn.adjustsImageWhenHighlighted=false
            
            
            // 监听按钮的点击
            btn.addTarget(self, action: "btnClicked:", forControlEvents: UIControlEvents.TouchDown)
            
            self.addSubview(btn)
            if(1==i){
                self.btnClicked(btn)
            }
        }
        
        
    }
    // 添加按钮
    func addTabBarButton(name:String,selName:String){
        var btn:UIButton=UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        // 设置按钮图片
        btn.setBackgroundImage(UIImage(named: name), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: selName), forState: UIControlState.Selected)
        btn.adjustsImageWhenHighlighted=false
        
        
        // 监听按钮的点击
        btn.addTarget(self, action: "btnClicked:", forControlEvents: UIControlEvents.TouchDown)
        
        self.addSubview(btn)
        
        btn.tag=self.subviews.count-1

    }
    
    weak var lastSelBtn:UIButton?
    
    // 点击按钮
    func btnClicked(btn:UIButton){
        if(lastSelBtn != nil){
            lastSelBtn!.selected=false
            lastSelBtn!.userInteractionEnabled=true
        }
        btn.selected=true
        btn.userInteractionEnabled=false
        lastSelBtn=btn
        // 切换控制器
//        if(tabBarClickBlock != nil){
//            tabBarClickBlock!(selectedIndex: btn.tag);
//        }
        
        if(delegate != nil){
            if(delegate!.respondsToSelector("tabBar:")){
                delegate!.tabBar(btn.tag)
            }
        }

    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var count=self.subviews.count
        
        var btnW=self.bounds.size.width/CGFloat(count)
        var btnH=self.bounds.size.height
        var btnX:CGFloat=0
        var btnY:CGFloat=0
        // 设置按钮的尺寸
        for i:Int in 0...count-1{
            var btn: UIButton=subviews[i] as! UIButton
            btnX=CGFloat(i)*btnW
            btn.frame=CGRectMake(btnX, btnY, btnW, btnH)
            if(i==0){
                btnClicked(btn)
            }
        }
    }

}
