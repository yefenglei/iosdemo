//
//  FLAddViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/6/27.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

protocol FLAddViewControllerDelegate:NSObjectProtocol{
    func addViewController(add:FLAddViewController,contact:FLContact)
}

class FLAddViewController: UIViewController {

    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    weak var delegate:FLAddViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        // 监听两个文本框
        // 3.添加Target
        nameField.addTarget(self, action: "TextChanged", forControlEvents: UIControlEvents.EditingChanged)
        phoneField.addTarget(self, action: "TextChanged", forControlEvents: UIControlEvents.EditingChanged)
        
        self.TextChanged()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addClicked(sender: UIButton) {
        var contact:FLContact=FLContact(name: nameField.text, phone: phoneField.text)
        if(delegate != nil){
            // 通知代理做事情
            delegate!.addViewController(self, contact: contact)
            
        }
        
        
        // 回上一个控制器
        self.navigationController?.popViewControllerAnimated(true)
    }
    func TextChanged(){
        // 判断两个文本框的内容
        if(nameField.text != "" && phoneField.text != ""){
            addBtn.enabled=true
        }else{
            addBtn.enabled=false
        }
        //NSLog("%@", accountField.text)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
