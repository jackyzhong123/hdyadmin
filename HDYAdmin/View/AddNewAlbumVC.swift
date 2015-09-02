//
//  AddNewAlbumVC.swift
//  HDYAdmin
//
//  Created by Sky on 15/9/1.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit

class AddNewAlbumVC: RootVC ,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBAction func buttonActionTouched(sender: UIButton) {
        var tag = sender.tag
        if(tag==1)
        {
            self.imgHeadChange();
        }else if (tag==2)
        {
            var dic = NSMutableDictionary(object: self.txtName!.text, forKey: "AlbumName")
            if(self.imageCover.sd_imageURL()==nil)
            {
                dic.setValue("http://hdy.awblob.com/protrait/default", forKey: "ImageUrl")
            }else
            {
                dic.setValue(self.imageCover!.sd_imageURL().absoluteString, forKey: "ImageUrl")
            }
            self.httpPostApi(AppConfig.Url_AddNewAlbum, body:dic, tag: 3)
            
        }
        
    }
    
    
    override func requestDataComplete(response: AnyObject, tag: Int) {
        SVProgressHUD.dismiss()
        if (tag == 21) {
            
            var url=response as! String
            self.imageCover!.sd_setImageWithURL(NSURL(string: url)!, placeholderImage: UIImage(named: "placeholder.png"))
            
        }else if(tag==3)
        {
            
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    
    
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var imageCover: UIImageView!
    
    //@IBOutlet var imageCover:UIImageView?
    //  @IBOutlet var txtName:UITextField?
    
    
    //MARK:修改用户头像
    func imgHeadChange()
    {
        var alertController = UIAlertController(title: "修改图像", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        var cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler:  {
            (action: UIAlertAction!) -> Void in
            
        })
        var deleteAction = UIAlertAction(title: "拍照上传", style: UIAlertActionStyle.Default, handler: {
            (action: UIAlertAction!) -> Void in
            
            var imagePicker = UIImagePickerController()
            if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
            {
                imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
                imagePicker.delegate = self;
                imagePicker.allowsEditing = true;
                self.presentViewController(imagePicker, animated: true, completion: nil);
            }
        })
        var archiveAction = UIAlertAction(title: "从相册中选择", style: UIAlertActionStyle.Default, handler: {
            (action: UIAlertAction!) -> Void in
            
            var imagePicker = UIImagePickerController()
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.delegate = self;
            imagePicker.allowsEditing = true;
            self.presentViewController(imagePicker, animated: true, completion: nil);
            
        })
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        alertController.addAction(archiveAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
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
    
    //MARK: UIImagePickerController delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        NSLog("count:%d", info);
        //编辑过后的图片
        let gotImage:UIImage! = info[UIImagePickerControllerEditedImage] as! UIImage
        picker.dismissViewControllerAnimated(true, completion: {
            () -> Void in
            
            
            if(gotImage != nil)
            {
                
                var imgData =  UIImageJPEGRepresentation(gotImage, 1.0)
                SVProgressHUD.showWithStatusWithBlack("请稍候，正在上传图片");
                self.uploadImage(imgData, tag: 21)
            }
        })
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

}
