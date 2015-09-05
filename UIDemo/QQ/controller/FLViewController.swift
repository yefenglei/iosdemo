//
//  FLViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/6/18.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class FLViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var tableView: UITableView!
    let ID:String="Cell"
    var messageFrames:[FLMessageFrameModel]=FLMessageFrameModel.messageFrameModels()
    var autoReplay:Dictionary<String,String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate=self
        self.tableView.dataSource=self
        self.input.delegate=self
        
        // 为tableView注册可重用单元格
        self.tableView.registerClass(FLMessageCell.self, forCellReuseIdentifier: ID)
        
        //cell 不可选中
        self.tableView.allowsSelection=false
        
        self.tableView.backgroundColor=UIColor(red: 225/255.0, green: 225/255.0, blue: 225/255.0, alpha: 1.0)
        
        self.tableView.separatorStyle=UITableViewCellSeparatorStyle.None
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        //设置左边距
        self.input.leftView=UIView(frame: CGRectMake(0, 0, 8, 0))
        //一直显示
        self.input.leftViewMode=UITextFieldViewMode.Always
        //加载自动回复内容
        setupAutoReply()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func setupAutoReply(){
        let path=NSBundle.mainBundle().pathForResource("autoReplay", ofType: "plist")
        let dataDict=NSDictionary(contentsOfFile: path!) as! Dictionary<String,String>
        self.autoReplay=dataDict
    }

    
    //点击右下角的send 按钮
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        NSLog("-------%@",textField.text)
        // 1.发送一条数据
        self.addMessage(textField.text, type: FLMessageModelType.FLMessageModelGatesby)
        
        //自动回复
        var autoStr=self.autoReplyWithText(textField.text)
        
        //将自动回复添加成一条聊天信息
        self.addMessage(autoStr, type: FLMessageModelType.FLMessageModelJobs)
        
        //4.清空文本框
        self.input.text=""
        return true
    }
    
    //    UIKeyboardAnimationCurveUserInfoKey = 7;  动画曲线动画
    //    UIKeyboardAnimationDurationUserInfoKey = "0.25"; 动画时间
    //    UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 216}}"; 键盘bounds
    //    UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 588}";  开始键盘的居中位置
    //    UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 372}";结束键盘的居中位置
    //    UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 480}, {320, 216}}"; 键盘开始弹出的frame
    //    UIKeyboardFrameChangedByUserInteraction = 0;   键盘改变frame
    //    UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 264}, {320, 216}}"; 退出键盘的frame
    
    //    UIKeyboardAnimationCurveUserInfoKey = 7;
    //    UIKeyboardAnimationDurationUserInfoKey = "0.25";
    //    UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 216}}";
    //    UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 372}";
    //    UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 588}";
    //    UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 264}, {320, 216}}";
    //    UIKeyboardFrameChangedByUserInteraction = 0;
    //    UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 480}, {320, 216}}";
    
    //当键盘frame 发生改变的时候调用
    func keyboardDidChangeFrame(noti:NSNotification){
        NSLog("--------%@",noti.userInfo!)
        //改变window的背景颜色
        self.view.window!.backgroundColor = self.tableView.backgroundColor;
        
        //最终键盘的frame
        var frame:CGRect = noti.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue();
        
        //键盘实时y
        var keyY:CGFloat = frame.origin.y;
        
        //屏幕的高度
        var screenH:CGFloat = UIScreen.mainScreen().bounds.size.height;
        
        //动画时间
        var keyDuration:CGFloat = noti.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! CGFloat;
        
        //执行动画
        UIView.animateWithDuration(NSTimeInterval(keyDuration), animations: { () -> Void in
            self.view.transform = CGAffineTransformMakeTranslation(0, keyY - screenH);
        })
        
        
    }
    
    // 当tableview 滚动的时候  结束编辑时间 退出键盘
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    func addMessage(text:String,type:FLMessageModelType){
        // 1.添加模型数据
        var msg:FLMessageModel=FLMessageModel()
        // 设置数据的值
        msg.time="16:58"
        msg.text=text
        msg.type=type
        
        //设置内容的frame,将msg 赋值给 fm中的message
        var fm:FLMessageFrameModel=FLMessageFrameModel(message: msg)
        
        self.messageFrames.append(fm)
        // 2.刷新表格
        self.tableView.reloadData()
        
        // 3. 自动上移
        // 移动的位置
        var path:NSIndexPath=NSIndexPath(forRow: self.messageFrames.count-1, inSection: 0)
        // 真正去的位置 atScrollPosition:滚到位置
        self.tableView.scrollToRowAtIndexPath(path, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    // 自动回复一条聊天信息
    func autoReplyWithText(text:String)->String{
        var t:NSString=text as NSString
        let length:Int=t.length
        for(var i=0;i<length;++i){
            var subStr:String=t.substringWithRange(NSMakeRange(i, 1))
            if((self.autoReplay[subStr]) != nil){
                return self.autoReplay[subStr]!
            }
        }
        return "滚蛋"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.messageFrames.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        // Configure the cell...
        
        /**
        在Storyboard中指定了可重用标示符，同时指定了Cell的类是HMStatusCell
        
        系统会为tableView注册一个原形Cell，专门用来做可重用单元格的，一旦缓冲区中不存在
        可重用单元格，系统会使用原形Cell新实例化一个Cell用程序使用！
        
        因此如果在，Storyboard中，注册了原形Cell，就不再需要 cell == nil的判断了
        */
        //    HMStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        // unable to dequeue a cell with identifier Cell - must register a nib or a class for the identifier or connect a prototype cell in a storyboard
        // 使用这个方法，要求一定注册可重用单元格，否则就会崩溃！
        // 官方建议使用以下方法，利用程序的崩溃，及时发现问题
        let cell = tableView.dequeueReusableCellWithIdentifier(ID, forIndexPath: indexPath) as! FLMessageCell
        let messageFrame=self.messageFrames[indexPath.row]
        cell.setFrameMessage(messageFrame)
        
        return cell
    }
    
    /** 计算单元格行高 */
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        /**
        计算行高的方法，会在加载表格数据时，有多少行计算多少次 contentSize
        
        问题：此方法执行的时候，cell还没有被实例化！
        但是：行高计算是在实例化cell时，通过设置status属性，计算的=>有了status模型，就可以知道行高！
        
        问题：如何在cell实例化之前，获得行高？
        解决方法：通过status可以计算得到行高！=》再建立一个模型，专门计算所有控件的位置
        */
        var messageFrame:FLMessageFrameModel=self.messageFrames[indexPath.row]
        return messageFrame.cellH!
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
