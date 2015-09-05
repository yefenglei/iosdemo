//
//  FLPaintViewController.swift
//  UIDemo
//
//  Created by 叶锋雷 on 15/7/9.
//  Copyright (c) 2015年 叶锋雷. All rights reserved.
//

import UIKit

class FLPaintViewController: UIViewController ,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    @IBAction func save(sender: UIBarButtonItem) {
        // 把画板截屏
        // 开启上下文
        UIGraphicsBeginImageContextWithOptions(paintView.bounds.size, false, 0.0)
        // 获取当前上下文
        var ctx:CGContextRef=UIGraphicsGetCurrentContext()
        // 把画板上的内容渲染到上下文
        paintView.layer.renderInContext(ctx)
        // 获取新的图片
        var newImage:UIImage=UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
        // 保存到用户的相册
        UIImageWriteToSavedPhotosAlbum(newImage, self, "image:didFinishSavingWithError:contextInfo:", nil)
        
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        if(error != nil){ // 保存失败
            MBProgressHUD.showError("保存失败")
        }else{ // 保存成功
            MBProgressHUD.showSuccess("保存成功")
        }
    }
    
    @IBAction func selectedPicture(sender: UIBarButtonItem) {
        // 去用户的相册
        var picker:UIImagePickerController=UIImagePickerController()
        // 数据源
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.delegate=self
        
        self.presentViewController(picker, animated: true, completion: nil)
        
    }
    // 选中照片的时候
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var image:UIImage=info[UIImagePickerControllerOriginalImage] as! UIImage
        
        var handleView:FLHandleImageView=FLHandleImageView(frame: self.paintView.frame)
        handleView.setUIImage(image)
        handleView.backgroundColor=UIColor.whiteColor()
        handleView.FLHandleImageViewBlock={(image)->Void
            in self.paintView.setUIImage(image)
        }
        self.view.addSubview(handleView)

        
        //paintView.setUIImage(image)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func eraser(sender: UIBarButtonItem) {
        paintView.eraser()
    }
    @IBAction func undo(sender: UIBarButtonItem) {
        paintView.undo()
    }
    @IBAction func clearScreen(sender: UIBarButtonItem) {
        paintView.clearScreen()
    }
    
    
    
    @IBAction func colorClicked(sender: UIButton) {
        paintView.color=sender.backgroundColor!
    }
    @IBOutlet weak var paintView: FLPaintView!
    @IBAction func SliderValueChanged(sender: UISlider) {
        paintView.lineWith = CGFloat(sender.value)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
