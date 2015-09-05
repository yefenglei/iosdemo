//
//  CPHtmlViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/8/23.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CPHtmlViewController: UIViewController,UIWebViewDelegate {

    var html:CPHelp!
    
    override func loadView() {
        self.view=UIWebView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.whiteColor()
        // Do any additional setup after loading the view.
        
        var cancelBtn=UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: "Back")
        self.navigationItem.leftBarButtonItem=cancelBtn
        
        var webView=self.view as! UIWebView
        var url=NSBundle.mainBundle().URLForResource(html.html, withExtension: nil)!
        var request=NSURLRequest(URL: url)
        webView.delegate=self
        webView.loadRequest(request)
    }
    
    // 网页加载完后调用
    func webViewDidFinishLoad(webView: UIWebView) {
        if(html.id != nil){
            var js:String="window.location.href='#\(html.id!)'"
            webView.stringByEvaluatingJavaScriptFromString(js)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 回到上一个控制器
    func Back(){
        self.dismissViewControllerAnimated(true, completion: nil)
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
