//
//  FLClockViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/7/12.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class FLClockViewController: UIViewController {
    @IBOutlet weak var clockView: UIImageView!
    var perSecondAngle:Int=6
    var perMinuteAngle:Int=6
    var perHourAngle:Int=30
    var perHourperMinuteAngle:Float = 0.5
    var perMinuteperSecondAngle:Float = 0.1
    
    var secondLayer:CALayer!
    var minuteLayer:CALayer!
    var hourLayer:CALayer!
    override func viewDidLoad() {
        super.viewDidLoad()

        //clockView.layer.transform = CATransform3DMakeRotation(-CGFloat(70.0/180.0*M_PI), 0, 0, 1)
        
        self.addSecondStick()
        self.addMinuteStick()
        self.addHourStick()
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true)
        
        update()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addSecondStick(){
        let clockWidth:CGFloat=200
        let clockHeight:CGFloat=200
        secondLayer=CALayer()
        // 1.设置锚点
        secondLayer.anchorPoint=CGPointMake(0.5, 1)
        // 2.设置起始位置
        secondLayer.position=CGPointMake(clockWidth * 0.5, clockHeight * 0.5)
        secondLayer.bounds=CGRectMake(0, 0, 1, clockHeight * 0.5-20)
        
        // 3. 设置背景颜色
        secondLayer.backgroundColor=UIColor.redColor().CGColor
        // 4. 添加到图层上
        clockView.layer.addSublayer(secondLayer)
    }
    
    func addMinuteStick(){
        let clockWidth:CGFloat=clockView.bounds.width
        let clockHeight:CGFloat=clockView.bounds.height
        minuteLayer=CALayer()
        // 1.设置锚点
        minuteLayer.anchorPoint=CGPointMake(0.5, 1)
        // 2.设置起始位置
        minuteLayer.position=CGPointMake(clockWidth * 0.5, clockHeight * 0.5)
        minuteLayer.bounds=CGRectMake(0, 0, 2, clockHeight * 0.5-35)
        minuteLayer.cornerRadius = CGFloat(1.0)
        // 3. 设置背景颜色
        minuteLayer.backgroundColor=UIColor.blueColor().CGColor
        // 4. 添加到图层上
        clockView.layer.addSublayer(minuteLayer)
        
    }
    
    func addHourStick(){
        let clockWidth:CGFloat=clockView.bounds.width
        let clockHeight:CGFloat=clockView.bounds.height
        hourLayer=CALayer()
        // 1.设置锚点
        hourLayer.anchorPoint=CGPointMake(0.5, 1)
        // 2.设置起始位置
        hourLayer.position=CGPointMake(clockWidth * 0.5, clockHeight * 0.5)
        hourLayer.bounds=CGRectMake(0, 0, 4, clockHeight * 0.5-50)
        hourLayer.cornerRadius=CGFloat(4)
        // 3. 设置背景颜色
        hourLayer.backgroundColor=UIColor.blackColor().CGColor
        // 4. 添加到图层上
        clockView.layer.addSublayer(hourLayer)
        
    }
    
    func update(){
        // 5. 获取日历对象
        var calender:NSCalendar=NSCalendar.currentCalendar()
        // 6. 获取日历组件
        var companents:NSDateComponents=calender.components(NSCalendarUnit.CalendarUnitSecond | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitHour, fromDate: NSDate())
        //NSCalendarUnitSecond
        // 7. 获取秒数
        var sec:Int=companents.second
        var min:Int=companents.minute
        var hour:Int=companents.hour
        
        //NSLog("\(sec)秒")
        
        var secondAngle:CGFloat = getSecondAngle(sec)
        var minuteAngle:CGFloat=getMinuteAngle(min)
        var hourAngle:CGFloat=getHourAngle(hour)
        hourAngle += getHourAngleByMinutes(min)
        minuteAngle += getMinuteAngelBySeconds(sec)
        
        secondLayer.transform=CATransform3DMakeRotation(secondAngle, 0, 0, 1)
        minuteLayer.transform=CATransform3DMakeRotation(minuteAngle, 0, 0, 1)
        hourLayer.transform=CATransform3DMakeRotation(hourAngle, 0, 0, 1)

    }
    
    func getSecondAngle(seconds:Int)->CGFloat{
        return CGFloat(Double(seconds*perSecondAngle) * M_PI/180.0)
    }
    
    func getMinuteAngle(minutes:Int)->CGFloat{
        return CGFloat(Double(minutes*perMinuteAngle) * M_PI/180.0)
    }
    
    func getHourAngle(hours:Int)->CGFloat{
        return CGFloat(Double(hours*perHourAngle) * M_PI/180.0)
    }
    
    func getHourAngleByMinutes(minutes:Int)->CGFloat{
        return CGFloat(Double(Float(minutes) * perHourperMinuteAngle) * M_PI/180.0)
    }
    
    func getMinuteAngelBySeconds(seconds:Int)->CGFloat{
        return CGFloat(Double(Float(seconds)*perMinuteperSecondAngle) * M_PI/180.0)
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
