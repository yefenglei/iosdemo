//
//  MyCell.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/6/11.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {
    @IBOutlet weak var buycountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    
    
    static func cellWithTableView(tableView:UITableView)->MyCell{
        var ID:String="Cell"
        var cell:MyCell? = tableView.dequeueReusableCellWithIdentifier(ID) as? MyCell
        if(cell == nil){
            NSLog("加载xib")
            cell=NSBundle.mainBundle().loadNibNamed("MyCell", owner: nil, options: nil).last as? MyCell
        }
        return cell!
    }
    
    func setTg(tg:MyTg){
        self.titleLabel.text=tg.title
        self.iconView.image=UIImage(named: tg.icon!)
        self.priceLabel.text=tg.price
        self.buycountLabel.text=tg.buyCount
    }
    /**
    从XIB被加载之后，会自动被调用，如果使用纯代码，不会被执行
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    /**
    Cell 被选中或者取消选中是都会被调用
    
    如果是自定义Cell控件，所有的子控件都应该添加到contentView中
    */
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if(selected){
            self.contentView.backgroundColor=UIColor.yellowColor()
        }else{
            self.contentView.backgroundColor=UIColor.whiteColor()
        }
    }
    
    

}
