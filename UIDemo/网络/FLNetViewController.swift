//
//  FLNetViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/7/22.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class FLNetViewController: UIViewController,NSURLConnectionDataDelegate,NSURLSessionDownloadDelegate {


    
    // 断点下载
    var conn:NSURLConnection!
    @IBAction func continuedDownloadClicked(sender: UIButton) {
        sender.selected = !sender.selected
        if(sender.selected){
            sender.setTitle("暂停", forState: UIControlState.Selected)
            var url:NSURL = NSURL(string: "http://down.pcgeshi.com/FormatFactory_setup.exe")!
            var request:NSMutableURLRequest=NSMutableURLRequest(URL: url)
            // 设置请求头
            var range:String="bytes=\(self.currentLength)-"
            request.setValue(range, forHTTPHeaderField: "Range")
            // 下载 发起一个异步请求
            self.conn=NSURLConnection(request: request, delegate: self)
        }else{
            sender.setTitle("继续", forState: UIControlState.Normal)
            // 暂停下载
            self.conn.cancel()
            self.conn=nil
        }
    }
    @IBOutlet weak var progress: UIProgressView!
    @IBAction func btnDownLoadBigDataClicked(sender: UIButton) {
        downloadbigdata()
    }
    @IBAction func listenNetBtn(sender: UIButton) {
        listenNetwork()
    }
    var reachability:Reachability!
    @IBAction func checkNetStatus(sender: UIButton) {
        if(FLNetworkTool.isEnableWifi()){
            MBProgressHUD.showSuccess("当前是wifi网路")
        }else if(FLNetworkTool.isEnable3G()){
            MBProgressHUD.showSuccess("当前是2g或3g网路")
        }else{
            MBProgressHUD.showError("没有网络")
        }
        
    }
    @IBAction func GBtn(sender: UIButton) {
        isEnable3G()
    }
    @IBAction func wifiBtn(sender: UIButton) {
        isEnableWifi()
    }
    @IBAction func sendRequest(sender: UIButton) {
        self.postRequest()
    }
    
    func listenNetwork(){
        // 监听网络状态发生改变的通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "networkChanged", name: kReachabilityChangedNotification, object: nil)
        // 活的Reachability对象
        reachability=Reachability.reachabilityForInternetConnection()
        reachability.startNotifier()
        
    }
    
    func networkChanged(){
        //MBProgressHUD.showSuccess("网络状态改变了！")
        checkLocalNetStatus()
    }
    
    func checkLocalNetStatus(){
        if(FLNetworkTool.isEnableWifi()){
            MBProgressHUD.showSuccess("当前是wifi网路")
        }else if(FLNetworkTool.isEnable3G()){
            MBProgressHUD.showSuccess("当前是2g或3g网路")
        }else{
            MBProgressHUD.showError("没有网络")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 监听网络
    func isEnableWifi(){
        // 1.获取reachability对象
        var wifi:Reachability=Reachability.reachabilityForLocalWiFi()
        // 2.获得Reachability对象的当前网络状态
        var wifiStatus=wifi.currentReachabilityStatus()
        
        if(wifiStatus.value != NotReachable.value){
            MBProgressHUD.showSuccess("wifi状态良好！")
        }
        
    }
    
    func isEnable3G(){
        // 1.获取reachability对象
        var wifi:Reachability=Reachability.reachabilityForInternetConnection()
        // 2.获得Reachability对象的当前网络状态
        var wifiStatus=wifi.currentReachabilityStatus()
        
        if(wifiStatus.value != NotReachable.value){
            MBProgressHUD.showSuccess("3G状态良好！")
        }
        
    }
    
    
    // 发送post请求
    func postRequest(){
        var url:NSURL = NSURL(string: "http://localhost/ThinkPHP/index.php/Home/Index/getJson")!
        var request:NSMutableURLRequest=NSMutableURLRequest(URL: url)
        // 设置超时时间
        request.timeoutInterval=10 //10秒
        request.HTTPMethod="POST"
        // 设置请求体
        var param:String="username=yefenglei&password=123456"
        request.HTTPBody=param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        // 设置请求头信息
        request.setValue("IPhone5.9", forHTTPHeaderField: "User-Agent")
        
        // 发送一个同步请求
        var queue:NSOperationQueue=NSOperationQueue.mainQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue) { (response, data, error) -> Void in
            if(error != nil){
                NSLog("%@", error)
                MBProgressHUD.showError("网络在开小差，请稍后再试!")
            }else{
                var dictData:NSDictionary?=NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary
                if(dictData == nil){
                    MBProgressHUD.showError("Json数据转换失败!")
                }else{
                    var name:String = dictData!.valueForKey("name") as! String
                    var nickname:String = dictData!.valueForKey("nick") as! String
                    var message:String="姓名:\(name),绰号:\(nickname)"
                    
                    MBProgressHUD.showSuccess(message)
                    
                    
                }
            }
        }
    }
    
    var data:NSMutableData=NSMutableData()
    var totalLength:Int64!
    var writeHandle:NSFileHandle!
    var currentLength:Int64=0
    // 下载大数据
    func downloadbigdata(){
        var urlStr:String="http://down.pcgeshi.com/FormatFactory_setup.exe"
        var url:NSURL = NSURL(string: urlStr)!
        var request:NSURLRequest=NSURLRequest(URL: url)
        var conn:NSURLConnection=NSURLConnection(request: request, delegate: self)!
    }
    // 1.接受到服务器的响应就会调用
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse){
        // 获取文件总大小
        //var response:NSHTTPURLResponse=response as! NSHTTPURLResponse
        //totalLength=response.allHeaderFields["Content-Length"]?.longLongValue
        
        if(self.currentLength>0){
            return
        }
        
        totalLength=response.expectedContentLength
        
        // 创建一个跟服务器端文件一样大的文件 到沙盒 中
        var mgr:NSFileManager=NSFileManager.defaultManager()
        var cache:String = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.CachesDirectory,  NSSearchPathDomainMask.UserDomainMask, true).last as! String
        // 文件路径
        var filePath:String=cache.stringByAppendingPathComponent("FormatFactory_setup.exe")
        // 创建空文件到沙盒
        mgr.createFileAtPath(filePath, contents: nil, attributes: nil)
        //创建一个用来写数据的文件句柄
        self.writeHandle=NSFileHandle(forWritingAtPath: filePath)!
        
        
    }
    // 2.当接收到服务器返回的实体数据时调用
    func connection(connection: NSURLConnection, didReceiveData data: NSData){
//        self.data.appendData(data)
        currentLength=currentLength+data.length
        self.progress.progress = Float(currentLength)/Float(totalLength)
//        NSLog("\(self.data.length)")
        // 移动到文件的最后面
        self.writeHandle.seekToEndOfFile()
        // 写入数据
        self.writeHandle.writeData(data)
    }
    // 3.加载完毕后调用
    func connectionDidFinishLoading(connection: NSURLConnection) {
        NSLog("下载完毕")
//        var cache:String = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.CachesDirectory,  NSSearchPathDomainMask.UserDomainMask, true).last as! String
//        var filePath:String=cache.stringByAppendingString("bilibili.jpg")
//        // 写到沙盒中
//        self.data.writeToFile(filePath, atomically: true)
        
        self.writeHandle.closeFile()
        self.writeHandle=nil
        self.totalLength=0
        self.currentLength=0
        
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        NSLog("下载出错了")
    }
    
    
    // MARK: - NSURLSESSION
    @IBAction func sessionBtnClicked(sender: UIButton) {
        //sessionGetDemo()
        //sessionPostDemo()
        //downloadTask()
        sessionContinuedDownload()
    }
    
    // get 请求
    func sessionGetDemo(){
        // 1.得到session对象
        var session:NSURLSession=NSURLSession.sharedSession()
        // 2.创建一个task
        var urlStr:String="http://localhost/ThinkPHP/index.php/Home/Index/getJson"
        var url:NSURL=NSURL(string: urlStr)!
        var task:NSURLSessionDataTask=session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            if(error != nil){
                NSLog("%@", error)
                MBProgressHUD.showError("网络在开小差，请稍后再试!")
            }else{
                var dictData:NSDictionary?=NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary
                if(dictData == nil){
                    MBProgressHUD.showError("Json数据转换失败!")
                }else{
                    var name:String = dictData!.valueForKey("name") as! String
                    var nickname:String = dictData!.valueForKey("nick") as! String
                    var message:String="姓名:\(name),绰号:\(nickname)"
                    

                    // 回主线程
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        MBProgressHUD.showSuccess(message)
                    })
                    
                }
                NSLog("下载完成")
            }
        })
        task.resume()
    }
    
    func sessionPostDemo(){
        // 1.得到session对象
        var session:NSURLSession=NSURLSession.sharedSession()
        // 2.创建一个task
        var url:NSURL = NSURL(string: "http://localhost/ThinkPHP/index.php/Home/Index/getJson")!
        var request:NSMutableURLRequest=NSMutableURLRequest(URL: url)
        // 设置超时时间
        request.timeoutInterval=10 //10秒
        request.HTTPMethod="POST"
        // 设置请求体
        var param:String="username=yefenglei&password=123456"
        request.HTTPBody=param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        // 设置请求头信息
        request.setValue("IPhone5.9", forHTTPHeaderField: "User-Agent")
        
        var task:NSURLSessionDataTask=session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if(error != nil){
                NSLog("%@", error)
                MBProgressHUD.showError("网络在开小差，请稍后再试!")
            }else{
                var dictData:NSDictionary?=NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary
                if(dictData == nil){
                    MBProgressHUD.showError("Json数据转换失败!")
                }else{
                    var name:String = dictData!.valueForKey("name") as! String
                    var nickname:String = dictData!.valueForKey("nick") as! String
                    var message:String="姓名:\(name),绰号:\(nickname)"
                    
                    // 回主线程
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        MBProgressHUD.showSuccess(message)
                    })
                    
                    
                }
                NSLog("下载完成")
            }
        })
        // 3.开始任务
        task.resume()
    }
    
    func downloadTask(){
        var session:NSURLSession=NSURLSession.sharedSession()
        var urlStr:String="http://down.pcgeshi.com/FormatFactory_setup.exe"
        var url:NSURL = NSURL(string: urlStr)!
        var task:NSURLSessionDownloadTask=session.downloadTaskWithURL(url, completionHandler: { (location, response, error) -> Void in
            NSLog("下载完毕--%@",location)
            var cachePath:String=NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.CachesDirectory,  NSSearchPathDomainMask.UserDomainMask, true).last as! String
            var filepath:String=cachePath.stringByAppendingPathComponent(response.suggestedFilename!)
            var sourcePath:String=location.path!
            // 将临时文件剪切到caches文件夹
            var mgr:NSFileManager=NSFileManager.defaultManager()
            mgr.moveItemAtPath(sourcePath, toPath: filepath, error: nil)
            
        })
        task.resume()
    }
    
    //带进度的下载
    func sessionContinuedDownload(){
        var sessionConfig=NSURLSessionConfiguration.defaultSessionConfiguration()
        var session:NSURLSession = NSURLSession(configuration: sessionConfig, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        var urlStr:String="http://down.pcgeshi.com/FormatFactory_setup.exe"
        var url:NSURL = NSURL(string: urlStr)!
        var task:NSURLSessionDownloadTask=session.downloadTaskWithURL(url)
        task.resume()
    }
    
    /* Sent when a download task that has completed a download.  The delegate should
    * copy or move the file at the given location to a new location as it will be
    * removed when the delegate message returns. URLSession:task:didCompleteWithError: will
    * still be called.
    */
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL){
        NSLog("下载完成")
        var cachePath:String=NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.CachesDirectory,  NSSearchPathDomainMask.UserDomainMask, true).last as! String
        var filepath:String=cachePath.stringByAppendingPathComponent(downloadTask.response!.suggestedFilename!)
        var sourcePath:String=location.path!
        // 将临时文件剪切到caches文件夹
        var mgr:NSFileManager=NSFileManager.defaultManager()
        mgr.moveItemAtPath(sourcePath, toPath: filepath, error: nil)

    }
    
    /* Sent periodically to notify the delegate of download progress. */
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64){
        var currentProcess=Double(totalBytesWritten)/Double(totalBytesExpectedToWrite)*100.0
        NSLog("当前进度:\(currentProcess)%" )
    }
    
    /* Sent when a download has been resumed. If a download failed with an
    * error, the -userInfo dictionary of the error will contain an
    * NSURLSessionDownloadTaskResumeData key, whose value is the resume
    * data.
    */
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64){
        
    }

    var urlsession:NSURLSession!
    var dlTask:NSURLSessionDownloadTask!
    var resumeData:NSData?
    
    func sessionInit(){
        var sessionConf=NSURLSessionConfiguration.defaultSessionConfiguration()
        urlsession=NSURLSession(configuration: sessionConf, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        
    }
    var oneToken:dispatch_once_t=dispatch_once_t()
    
    @IBAction func sessionDownloadBtnClicked(sender: UIButton) {
        // 只执行一次
        dispatch_once(&oneToken, { () -> Void in
            self.sessionInit()
        })
        sender.selected = !sender.selected
        if(sender.selected){
            sender.setTitle("暂停", forState: UIControlState.Selected)
            if(self.resumeData==nil){
                self.start()
            }else{
                self.resume()
            }
        }else{
            sender.setTitle("继续", forState: UIControlState.Normal)
            self.pause()
        }
        
    }
    
    func start(){
        var urlStr:String="http://down.pcgeshi.com/FormatFactory_setup.exe"
        var url:NSURL = NSURL(string: urlStr)!
        dlTask = urlsession.downloadTaskWithURL(url)
        dlTask.resume()

    }
    
    func resume(){
        self.dlTask=self.urlsession.downloadTaskWithResumeData(self.resumeData!)
        self.dlTask.resume()
        self.resumeData=nil
    }
    
    func pause(){
        self.dlTask.cancelByProducingResumeData { (data) -> Void in
            self.resumeData=data
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
