//
//  CPSettingTableViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/9.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CPSettingTableViewController: CPBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDataList(CPSettingData.dataList)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}
