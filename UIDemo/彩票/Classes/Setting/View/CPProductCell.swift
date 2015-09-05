//
//  CPProductCollectionViewCell.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/16.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CPProductCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var product:CPProduct!
    func setProduct(prod:CPProduct){
        self.product=prod
        self.imageView.image=UIImage(named: prod.icon)
        self.titleLabel.text=prod.title
    }
    
    override func awakeFromNib() {
        imageView.layer.cornerRadius=10
        imageView.clipsToBounds=true
    }
}
