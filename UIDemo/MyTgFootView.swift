//
//  MyTgFootView.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/6/13.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

protocol MyTgFootViewDelegate{
    func tgFooterViewDidDownloadButtonClick(tgFootView:MyTgFootView)
}

class MyTgFootView: UIView {
    var delegate:MyTgFootViewDelegate?
    @IBOutlet weak var btnLoadMore: UIButton!
    @IBOutlet weak var loadMoreSubView: UIView!
    @IBAction func btnLoadMoreClicked(sender: AnyObject) {
        NSLog("点击了加载按钮")
        self.btnLoadMore.hidden = true
        self.loadMoreSubView.hidden = false
        
        if(delegate != nil){
            self.delegate?.tgFooterViewDidDownloadButtonClick(self)
        }

//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(2 * NSEC_PER_SEC)),dispatch_get_main_queue(),{
//            ()-> Void in
//            //加载数据,使用代理
//            
//            self.endRefresh()
//        })
    }
    
    static func footerview()->MyTgFootView{
        return NSBundle.mainBundle().loadNibNamed("MyTgFootView", owner: nil, options: nil).last as! MyTgFootView
    }
    
    func endRefresh(){
        btnLoadMore.hidden = false
        loadMoreSubView.hidden = true
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
