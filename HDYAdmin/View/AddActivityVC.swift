//
//  AddActivityVC.swift
//  HDYAdmin
//
//  Created by Sky on 15/9/2.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit

class AddActivityVC: RootVC,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    //MARK: 页面变量
    
    
    @IBOutlet weak var DescriptionHeight: NSLayoutConstraint!
    
    
    
    
    
    @IBOutlet weak var baseScrollView: UIScrollView!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtAlbum: UITextField!
    @IBOutlet weak var txtActivityTime: UITextField!
    @IBOutlet var txtActivityDescrition: UITextView!
    @IBOutlet var txtLocation: UITextField!
    
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var imgCover: UIImageView!
    
    var postUrl:String = AppConfig.Url_DefaultImg
    
    //实体
    var albumDetail:AlbumDetail?
    var locationDetail:LocationDetail?
    
    var startTime:String?
    var endTime:String?
    var LocationProxy:String = ""
    
    
    
    //MARK: 页面生存周期
    override func viewDidLoad() {
        IsNeedDoneButton = true
        super.viewDidLoad()
        
    }
    
    
    
    func toggleRightMenu(sender: AnyObject)
    {
        if (locationDetail != nil)
        {
            LocationProxy = locationDetail!.Id
        }else
        {
            LocationProxy = ""
        }
        let parameter = [
            "ActivityPost":postUrl,
            "ActivityName":txtName.text,
            "ActivityStart":startTime,
            "ActivityEnd":endTime,
            "Album":albumDetail?.AlbumId,
            "Location":txtLocation.text,
            "LocationProxy":LocationProxy,
            "Description":txtDescription.text
        ]
        SVProgressHUD.showWithStatusWithBlack("保存中")

        self.httpPostApi(AppConfig.Url_AddActivity, body: parameter, tag: 10)
    }
    
    
    //MARK: 渲染详细
    override func RenderDetail()
    {
        UIHelper.SetNaviBarRightItemWithName(self, action: "toggleRightMenu:", strName: "保存")
        self.title="添加活动";
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"selectAlbum:" , name: AppConfig.NF_SelectAlbum, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"selectLocation:" , name: AppConfig.NF_SelectLocation, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"selectTime:" , name: AppConfig.NF_SelectTime, object: nil)
        
      
        txtAlbum.placeholder = "无"
        txtAlbum.enabled = false
        
        txtActivityTime.placeholder = "请选择"
        txtActivityTime.enabled = false
        
    }
    
    
    
    
    
    override  func  viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //baseScrollView.backgroundColor = UIColor.redColor()
        baseScrollView.contentSize = CGSizeMake(baseScrollView.frame.size.width, 5000)
       // txtDescription.frame = CGRectMake(txtDescription.frame.origin.x, txtDescription.frame.origin.y, txtDescription.frame.size.width, 4000)
        DescriptionHeight.constant = 4000
       }
    
 
    
    func selectLocation(notification:NSNotification) {
        
        self.locationDetail = notification.object as? LocationDetail;
        self.txtLocation.text = locationDetail?.LocationName
        
    }
    
    func selectTime(notification:NSNotification) {
        
        var model = notification.object as? TimeModel;
        self.startTime = model?.startTime
        self.endTime = model?.endTime
        self.txtActivityTime.text = startTime! + " -> " + endTime!
        
    }
    
    func selectAlbum(notification:NSNotification) {
        
        self.albumDetail = notification.object as? AlbumDetail;
        self.txtAlbum.text = albumDetail?.AlbumName
        
    }
    
    //MARK: 按钮点击事件
    override func ButtonTap(tag: Int) {
        if (tag == 10)
        {
            
             imgHeadChange()
            
        }else if (tag == 14)
        {
            var vc:MyAlbumListVC   = UIHelper.GetVCWithIDFromStoryBoard(.Main, viewControllerIdentity: "MyAlbumListVC") as! MyAlbumListVC
            vc.IsFromHome = false
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if(tag == 12 )
        {
            var vc:MyLocationVC  = UIHelper.GetVCWithIDFromStoryBoard(.Main, viewControllerIdentity: "MyLocationVC") as! MyLocationVC
            vc.IsFromHome = false
            self.navigationController?.pushViewController(vc, animated: true)
        }else if (tag == 11)
        {
            var vc:SelectTimeVC  = UIHelper.GetVCWithIDFromStoryBoard(.Main, viewControllerIdentity: "SelectTimeVC") as! SelectTimeVC
         
            //self.navigationController?.pushViewController(vc, animated: true)
            //self.navigationController?.popToViewController(vc, animated: true)
            self.presentViewController(vc, animated: true, completion: { () -> Void in
                
            })
        }
        
    }
    
    
    //MARK: 网络调用返回
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
        SVProgressHUD.dismiss()

        if (tag == 99)
        {
            
            
          
            self.imgCover!.sd_setImageWithURL(NSURL(string:response as! String)!, placeholderImage: UIImage(named: "placeholder.png"))
            postUrl = response as! String
                       return
        }else if (tag == 10)
        {
               self.navigationController?.popViewControllerAnimated(true);
        }
        
        
    }
    
    
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
                self.uploadImage(imgData, tag: 99)
            }
        })
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    
    
}
