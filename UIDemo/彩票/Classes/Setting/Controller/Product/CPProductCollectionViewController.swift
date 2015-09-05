//
//  CPProductCollectionViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/16.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class CPProductCollectionViewController: UICollectionViewController {

    var products:[CPProduct]!
    init(){
        // 流水布局
        var layout:UICollectionViewFlowLayout=UICollectionViewFlowLayout()
        // 每一个cell的尺寸
        layout.itemSize=CGSize(width: 80, height: 80)
        // 垂直间距
        layout.minimumLineSpacing=10
        // 水平间距
        layout.minimumInteritemSpacing=0
        // 内边距
        layout.sectionInset=UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        super.init(collectionViewLayout: layout)
        
        self.products=CPProduct.getProducts()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let cellID:String="productCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bounds=UIScreen.mainScreen().bounds
        self.collectionView!.backgroundColor=UIColor.whiteColor()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        var xib:UINib=UINib(nibName: "CPProductCell", bundle: nil)
        self.collectionView?.registerNib(xib, forCellWithReuseIdentifier: cellID)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return self.products.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! CPProductCell
    
        // Configure the cell
        // 获取模型
        var prod:CPProduct=self.products[indexPath.row]
        cell.setProduct(prod)
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // 获取模型
        var prod:CPProduct=self.products[indexPath.row]
        var urlStr="\(prod.customUrl)://\(prod.id)"
        var url=NSURL(string: urlStr)!
        var app=UIApplication.sharedApplication()
        NSLog("点击了\(prod.title)")
        if(app.canOpenURL(url)){ //已经安装该应用
            app.openURL(url)
        }else{ // 没有安装该应用， 跳转appstore
            app.openURL(NSURL(string: prod.url)!)
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
