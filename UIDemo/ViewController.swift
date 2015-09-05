//
//  ViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/6/2.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    @IBAction func Login(sender: UIButton) {
        NSLog("%@ %@ %@", __FUNCTION__,self.txtUserName.text,self.txtPW.text)
        self.txtUserName.clearButtonMode=UITextFieldViewMode.WhileEditing
    }
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtPW: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    
    //var view1:UIView=UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtUserName.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
        
        /**
        

        view1.frame=CGRectMake(0, 0, 200, 200)
        view1.backgroundColor=UIColor.redColor()
        self.view.addSubview(view1)
        
        var btn1:UIButton=UIButton()
        btn1.addTarget(self, action: "btn1_Clicked", forControlEvents: UIControlEvents.TouchUpInside)
        btn1.frame=CGRectMake(0, 300, 100, 50)
        btn1.setTitle("淡出", forState: UIControlState.Normal)
        btn1.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        //btn1.backgroundColor=UIColor.greenColor()
        self.view.addSubview(btn1)
        self.view.bringSubviewToFront(btn1)
        */
        
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        NSLog("%@ %@", self.txtUserName,self.txtPW)
        if(textField==self.txtUserName){
            self.txtPW.becomeFirstResponder()
        }else if(textField==self.txtPW)
        {
            textField.resignFirstResponder()
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func btn1_Clicked(){
        UIView.beginAnimations("animation1", context: nil)
        UIView.setAnimationDuration(1)
        //view1.alpha=0
        UIView.commitAnimations()
    }


}

