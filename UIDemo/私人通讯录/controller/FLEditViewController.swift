//
//  FLEditViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/6/27.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

protocol FLEditViewControllerDelegate{
    func EditViewController(sender:FLEditViewController,contact:FLContact)
}

class FLEditViewController: UIViewController,UITextFieldDelegate {
    var name:String?
    var phone:String?
    
    @IBAction func saveBtnClicked(sender: UIButton) {
        if(delegate != nil){
            var name:String=nameField.text
            var phone:String=phoneField.text
            var contact:FLContact=FLContact(name: name, phone: phone)
            delegate!.EditViewController(self, contact: contact)
            
            // 回上一个控制器
            self.navigationController?.popViewControllerAnimated(true)

        }
    }
    @IBAction func editBarBtnClicked(sender: UIBarButtonItem) {
        self.saveBtn.enabled=true
        self.nameField.enabled=true
        self.phoneField.enabled=true
        TextChanged()
    }
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    var delegate:FLEditViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化
        nameField.text=name
        phoneField.text=phone
        // 1.添加文本框监听时间
        nameField.addTarget(self, action: "TextChanged", forControlEvents: UIControlEvents.EditingChanged)
        phoneField.addTarget(self, action: "TextChanged", forControlEvents: UIControlEvents.EditingChanged)

        // Do any additional setup after loading the view.
    }

    func TextChanged(){
        self.saveBtn.enabled=(nameField.text != "" && phoneField.text != "")
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
