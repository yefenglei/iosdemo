//
//  FLLoginViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/6/27.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

let FLAccountKey:String="account"
let FLPwdKey:String="pwd"
let FLRmbPwdKey:String="rmbpwd"
let FLAutoLoginKey:String="autoLogin"

class FLLoginViewController: UIViewController,UITextFieldDelegate {
    /**
    执行segue的时候，跳转之前调用
    一般做跳转之前的准备工作，给下一个控制器传值
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc:UIViewController=segue.destinationViewController as! UIViewController
        vc.navigationItem.title="\(accountField.text)的联系人"
    }
    // MARK: - 生成分隔线
    // MARK: 说明
    // 用户点击登录
    @IBAction func loginClicked(sender: UIButton) {
        // 判断账号密码是否正确
        if(accountField.text=="fl" && pwdField.text=="123"){
            // 保存登陆数据
            NSUserDefaults.standardUserDefaults().setObject(accountField.text, forKey: FLAccountKey)
            NSUserDefaults.standardUserDefaults().setObject(pwdField.text, forKey: FLPwdKey)
            NSUserDefaults.standardUserDefaults().setBool(rmbPwdS.on, forKey: FLRmbPwdKey)
            NSUserDefaults.standardUserDefaults().setBool(autoLoginS.on, forKey: FLAutoLoginKey)
            // 同步数据
            NSUserDefaults.standardUserDefaults().synchronize()
            
            // 跳转联系人界面
            
            // 1.storyboard
            /*
            var sb:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
            var vc:UIViewController=sb.instantiateViewControllerWithIdentifier("contacts") as! UIViewController
            NSLog("%@", vc)
            self.navigationController?.showViewController(vc, sender: nil)
            */
            
            // 2.segue
            // 显示遮盖
            
            
            MBProgressHUD.showMessage("正在登录中...")
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), { () -> Void in
                // 移除遮罩
                MBProgressHUD.hideHUD()
                self.accountField.resignFirstResponder()
                self.pwdField.resignFirstResponder()
                self.performSegueWithIdentifier("login2contact", sender: nil)
            })
            
            
            
        }else{
            //var alert:UIAlertView = UIAlertView(title: "账号或密码错误", message: nil, delegate: nil, cancelButtonTitle: "取消")
            //alert.show()
            MBProgressHUD.showError("账号或密码错误")
        }
    }
    
    @IBOutlet weak var rmbPwdS: UISwitch!
    @IBOutlet weak var autoLoginS: UISwitch!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var pwdField: UITextField!
    @IBOutlet weak var accountField: UITextField!
    
    
    // 当自动登陆状态改变的时候调用
    @IBAction func autoLoginSwitch(sender: UISwitch) {
        if(sender.on==true){
            rmbPwdS.setOn(true, animated: true)
        }
    }
    //当记住密码状态改变的时候调用
    @IBAction func rmbPwdSwitch(sender: UISwitch) {
        if(sender.on==false){
            autoLoginS.setOn(false, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.代理
        //        accountField.delegate=self
        //        pwdField.delegate=self
        
        // 2.通知
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "TextChanged", name: UITextFieldTextDidChangeNotification, object: accountField)
        // 监听两个文本框
        // 3.添加Target
        accountField.addTarget(self, action: "TextChanged", forControlEvents: UIControlEvents.EditingChanged)
        pwdField.addTarget(self, action: "TextChanged", forControlEvents: UIControlEvents.EditingChanged)
        
        // 读取系统偏好数据
        accountField.text = NSUserDefaults.standardUserDefaults().objectForKey(FLAccountKey) as? String
        rmbPwdS.on=NSUserDefaults.standardUserDefaults().boolForKey(FLRmbPwdKey)
        if(rmbPwdS.on){
            pwdField.text = NSUserDefaults.standardUserDefaults().objectForKey(FLPwdKey) as? String
        }
        autoLoginS.on=NSUserDefaults.standardUserDefaults().boolForKey(FLAutoLoginKey)

        self.TextChanged()
        
        if(autoLoginS.on){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * NSEC_PER_MSEC)), dispatch_get_main_queue(), { () -> Void in
                self.loginClicked(self.loginBtn)
            })
        }
        

        // Do any additional setup after loading the view.
    }
    
    func TextChanged(){
        // 判断两个文本框的内容
        if(accountField.text != "" && pwdField.text != ""){
            loginBtn.enabled=true
        }else{
            loginBtn.enabled=false
        }
        //NSLog("%@", accountField.text)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    //        NSLog("%@", textField.text)
    //        return true
    //    }
    
    /*
    optional func textFieldShouldBeginEditing(textField: UITextField) -> Bool // return NO to disallow editing.
    optional func textFieldDidBeginEditing(textField: UITextField) // became first responder
    optional func textFieldShouldEndEditing(textField: UITextField) -> Bool // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    optional func textFieldDidEndEditing(textField: UITextField) // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    
    optional func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool // return NO to not change text
    
    optional func textFieldShouldClear(textField: UITextField) -> Bool // called when clear button pressed. return NO to ignore (no notifications)
    optional func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
