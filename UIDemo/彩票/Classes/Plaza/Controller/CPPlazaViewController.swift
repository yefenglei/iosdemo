//
//  CPPlazaViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/9/5.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class CPPlazaViewController: UIViewController {
    @IBAction func stop(sender: UIButton) {
        luckywheel.endRotate()
    }
    @IBAction func start(sender: UIButton) {
        luckywheel.startRotate()
    }

    var luckywheel:CPWheelView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        luckywheel=CPWheelView.wheelView()
        luckywheel.center=self.view.center
        self.view.addSubview(luckywheel)
        
        self.view.backgroundColor=UIColor.whiteColor()
        
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
