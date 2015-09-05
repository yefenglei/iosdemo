//
//  FLAFNViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/7/26.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class FLAFNViewController: UIViewController {

    @IBAction func afn1Clicked(sender: UIButton) {
        afnDemo1()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func afnDemo1(){
        // 1.创建一个请求操作管理者
        var mgr:AFHTTPRequestOperationManager=AFHTTPRequestOperationManager()
        
        // 2.发送一个get请求
        var url="http://localhost/ThinkPHP/index.php/Home/Index/getJson"
        var params:Dictionary<String,String> = Dictionary<String,String>()
        params["username"]="123"
        
        mgr.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        
        mgr.GET(url, parameters: params, success: { (operation, obj) -> Void in
            NSLog("请求成功")
        }) { (operation, error) -> Void in
            NSLog("请求失败")
            NSLog(error.userInfo!.description)
        }
    }
    
    func getSession(){
        var mgr:AFHTTPSessionManager=AFHTTPSessionManager()
        // 2.发送一个get请求
        var url="http://localhost/ThinkPHP/index.php/Home/Index/getJson"
        var params:Dictionary<String,String> = Dictionary<String,String>()
        params["username"]="123"
        mgr.GET(url, parameters: params, success: { (operation, obj) -> Void in
            NSLog("请求成功")
            }) { (operation, error) -> Void in
                NSLog("请求失败")
                NSLog(error.userInfo!.description)
        }
        
    }

    @IBAction func uploadFileClicked(sender: UIButton) {
        uploadFile()
    }
    
    func uploadFile(){
        var mgr:AFHTTPRequestOperationManager=AFHTTPRequestOperationManager()
        var params:Dictionary<String,String> = Dictionary<String,String>()
        params["username"]="上传者"
        
        var url="http://localhost/ThinkPHP/index.php/Home/Index/getJson"
        
        mgr.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        mgr.POST(url, parameters: params, constructingBodyWithBlock: { (fromDataObj) -> Void in
            var fromData:AFMultipartFormData = fromDataObj as AFMultipartFormData
            var image=UIImage(named: "Stars.png")
            var fileData=UIImagePNGRepresentation(image)
            fromData.appendPartWithFileData(fileData, name: "file", fileName: "hehe.png", mimeType: "image/png")
            
            
        }, success: { (operation, obj) -> Void in
            NSLog("上传成功")
        }) { (operation, error) -> Void in
            NSLog("上传失败")
            NSLog(error.userInfo!.description)

        }
        
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
