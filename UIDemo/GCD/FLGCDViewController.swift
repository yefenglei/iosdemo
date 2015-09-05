//
//  FLGCDViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/7/14.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class FLGCDViewController: UIViewController {
    @IBOutlet weak var imageView1: UIImageView!
    var oneToken:dispatch_once_t=dispatch_once_t()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        //一次性代码()
        //合并图片()
        
        //demo1()
        //demo2()
        SDWebImageDemo()
        
    }
    
    func 多线程(){
        // 获取全局并发队列
        var queue:dispatch_queue_t=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        // 讲任务添加到全局队列中去异步执行
        dispatch_async(queue, { () -> Void in
            NSLog("---下载图片1---%@", NSThread.currentThread())
        })
        dispatch_async(queue, { () -> Void in
            NSLog("---下载图片2---%@", NSThread.currentThread())
        })
        dispatch_async(queue, { () -> Void in
            NSLog("---下载图片3---%@", NSThread.currentThread())
        })
        dispatch_async(queue, { () -> Void in
            NSLog("---下载图片4---%@", NSThread.currentThread())
        })
        dispatch_async(queue, { () -> Void in
            NSLog("---下载图片5---%@", NSThread.currentThread())
        })
    }
    
    func 一次性代码(){
        
        dispatch_once(&oneToken, { () -> Void in
            self.sayHello()
        })
    }
    
    func sayHello(){
        NSLog("Hello")
    }
    
    func 合并图片(){
        var queue:dispatch_queue_t=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(queue, { () -> Void in
            var url1:NSURL = NSURL(string: "http://e.hiphotos.baidu.com/image/pic/item/0823dd54564e925805c37dec9e82d158ccbf4e39.jpg")!
            var url2:NSURL = NSURL(string: "http://www.logoing.net/wp-content/uploads/2012/08/baidulogo1.jpg")!
            var data1:NSData=NSData(contentsOfURL: url1)!
            var data2:NSData=NSData(contentsOfURL: url2)!
            var image1:UIImage=UIImage(data: data1)!
            var image2:UIImage=UIImage(data: data2)!
            
            // 合并图片
            UIGraphicsBeginImageContextWithOptions(image1.size, false, 0)
            
            image1.drawInRect(CGRectMake(0, 0, image1.size.width, image1.size.width))
            image2.drawInRect(CGRectMake(0, 0, image2.size.width, image2.size.width))
            
            var fullImage:UIImage=UIGraphicsGetImageFromCurrentImageContext()
            
            // 关闭上下文
            UIGraphicsEndImageContext()
            // 返回主线程
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.imageView1.image=fullImage
            })
            
        })
    }
    
    // MARK: - NSOperation 实例
    // NSBlockOperation
    func demo1(){
        // 创建异步队列
        var queue:NSOperationQueue = NSOperationQueue()
        // 设置最大并发
        queue.maxConcurrentOperationCount=2;
        // 创建闭包操作
        var operation1=NSBlockOperation { () -> Void in
            NSLog("下载图片1----当前线程%@",NSThread.currentThread() )
        }
        var operation2=NSBlockOperation { () -> Void in
            NSLog("下载图片2----当前线程%@",NSThread.currentThread() )
        }
        // 给operation2添加额外操作
        operation2.addExecutionBlock { () -> Void in
            NSLog("下载图片2之后添加水印----当前线程%@",NSThread.currentThread() )
        }
        // 给operation2添加完成后的回调事件
        operation2.completionBlock={()->Void in
            NSLog("保存图片2----当前线程%@",NSThread.currentThread() )
        }
        var operation3=NSBlockOperation { () -> Void in
            NSLog("下载图片3----当前线程%@",NSThread.currentThread() )
        }
        var operation4=NSBlockOperation { () -> Void in
            NSLog("下载图片4----当前线程%@",NSThread.currentThread() )
        }
        // 添加各个线程之间的依赖关系
        operation1.addDependency(operation2)
        operation2.addDependency(operation3)
        operation3.addDependency(operation4)

        // 将操作添加到队列中
        queue.addOperation(operation1)
        queue.addOperation(operation2)
        queue.addOperation(operation3)
        queue.addOperation(operation4)
        
    }
    
    // 下载图片
    func demo2(){
        var queue:NSOperationQueue=NSOperationQueue()
        queue.addOperationWithBlock { () -> Void in
            var url1:NSURL = NSURL(string: "http://e.hiphotos.baidu.com/image/pic/item/0823dd54564e925805c37dec9e82d158ccbf4e39.jpg")!
            var data1:NSData=NSData(contentsOfURL: url1)!
            var image1:UIImage=UIImage(data: data1)!
            
            // 回主线程
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.imageView1.image=image1
            })
        }
    }
    
    func SDWebImageDemo(){
        
        var optionArray:SDWebImageOptions=SDWebImageOptions.RetryFailed|SDWebImageOptions.LowPriority
        
        var imgUrl:NSURL? = NSURL(string: "http://e.hiphotos.baidu.com/image/pic/item/0823dd54564e925805c37dec9e82d158ccbf4e39.jpg")
        var image:UIImage=UIImage(named: "clock_body.jpg")!
        //self.imageView1.sd_setImageWithURL(imgUrl, placeholderImage: image)
        self.imageView1.sd_setImageWithURL(imgUrl!, placeholderImage: image, options: optionArray, progress: { (receivedSize, expectedSize) -> Void in
            NSLog("下载进度：%f", Float(receivedSize) * 1.0 / Float(expectedSize))
        }) { (img, error, cacheType, imgUrl) -> Void in
            NSLog("图片加载完毕：%@", img)
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
