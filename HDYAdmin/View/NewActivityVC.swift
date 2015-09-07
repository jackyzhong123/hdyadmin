//
//  NewActivityVC.swift
//  HDYAdmin
//
//  Created by haha on 15/9/7.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit


class NewActivityVC: RootVC ,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    var albumDetail:AlbumDetail?
    var locationDetail:LocationDetail?
    
    //MARK: 页面变量
    var listData:Array<LocationDetail> = []
    let cellIdentifier:String = "Cell"
    
    var imgCover = AppConfig.Url_DefaultImg
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: 页面生存周期
    override func viewDidLoad() {
        IsNeedDoneButton = true
        super.viewDidLoad()
        self.title="新建活动";
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    //MARK: 渲染详细
    override func RenderDetail()
    {
        
        UIHelper.SetNaviBarRightItemWithName(self, action: "toggleRightMenu:", strName: "保存")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"selectAlbum:" , name: AppConfig.NF_SelectAlbum, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"selectLocation:" , name: AppConfig.NF_SelectLocation, object: nil)
        
    }
    
    
    
    
    
    func toggleRightMenu(sender: AnyObject)
    {
        //        let parameter = [
        //            "ActivityPost":"",
        //            "ActivityName":txtName.text,
        //            "ActivityStart":txtStart.titleLabel?.text,
        //            "ActivityEnd":txtEnd.titleLabel?.text,
        //            "Album":txtAlbum.text,
        //            "Location":txtLocation.text,
        //            "LocationProxy":txtLocation.text,
        //            "Description":txtActivityDescrition.text
        //        ]
        //
        //        self.httpPostApi(AppConfig.Url_AddActivity, body: parameter, tag: 10)
    }
    
    
    func selectAlbum(notification:NSNotification) {
        
        
        var indePath:NSIndexPath = NSIndexPath(forRow: 3, inSection: 0)
        var cell : NALabel_Text_IconCell = self.tableView.cellForRowAtIndexPath(indePath) as! NALabel_Text_IconCell
        self.albumDetail = notification.object as? AlbumDetail;
        cell.myText.text = albumDetail?.AlbumName
    }
    
    func selectLocation(notification:NSNotification) {
        
        var indePath:NSIndexPath = NSIndexPath(forRow: 4, inSection: 0)
        var cell : NALabel_Text_IconCell = self.tableView.cellForRowAtIndexPath(indePath) as! NALabel_Text_IconCell
        self.locationDetail = notification.object as? LocationDetail;
        cell.myText.text = locationDetail?.LocationName
    }
    
    
    
    
    //MARK: 按钮点击事件
    override func ButtonTap(tag: Int) {
        
    }
    
    
    //MARK: 网络调用返回
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
        
        if (tag == 99)
        {
            
            var indePath:NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
            var cell : NA_ImageCell = self.tableView.cellForRowAtIndexPath(indePath) as! NA_ImageCell
            cell.imgCover!.sd_setImageWithURL(NSURL(string:response as! String)!, placeholderImage: UIImage(named: "placeholder.png"))
            self.imgCover = response as! String
            SVProgressHUD.dismiss()
        }
        
        
        if (response is NSDictionary)
        {
            
            var jsonData=JSON(response)
            
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 0)
        {
            return 83
        }else if (indexPath.row == 5)
        {
            return 1000
        }else
        {
            return 44
        }
    }
    
    
    //MARK: 表格选项
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.row == 0)
        {
            imgHeadChange()
        }else if (indexPath.row == 3)
        {
            //var cell:NALabel_Text_IconCell = tableView.cellForRowAtIndexPath(indexPath)!
            var vc:MyAlbumListVC   = UIHelper.GetVCWithIDFromStoryBoard(.Main, viewControllerIdentity: "MyAlbumListVC") as! MyAlbumListVC
            vc.IsFromHome = false
            self.navigationController?.pushViewController(vc, animated: true)
        }else if (indexPath.row == 4)
        {
            var vc:MyLocationVC  = UIHelper.GetVCWithIDFromStoryBoard(.Main, viewControllerIdentity: "MyLocationVC") as! MyLocationVC
            vc.IsFromHome = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        
        // cell.selected = false
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell =  tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! UITableViewCell
        
        if (indexPath.row == 0)
        {
            var customCell:NA_ImageCell =  tableView.dequeueReusableCellWithIdentifier("NA_ImageCell") as! NA_ImageCell
            // customCell.imgCover
            
            return customCell;
        }else  if (indexPath.row == 1)
        {
            var customCell:NALabel_TextCell =  tableView.dequeueReusableCellWithIdentifier("NALabel_TextCell") as! NALabel_TextCell
            // customCell.imgCover
            customCell.title.text = "活动名称"
            
            
            return customCell;
        }else  if (indexPath.row == 2)
        {
            var customCell:NALabel_Text_IconCell =  tableView.dequeueReusableCellWithIdentifier("NALabel_Text_IconCell") as! NALabel_Text_IconCell
            // customCell.imgCover
            customCell.title.text = "活动时间"
            
            
            return customCell;
        }else  if (indexPath.row == 3)
        {
            var customCell:NALabel_Text_IconCell =  tableView.dequeueReusableCellWithIdentifier("NALabel_Text_IconCell") as! NALabel_Text_IconCell
            // customCell.imgCover
            customCell.title.text = "系列活动"
            
            
            return customCell;
        }else  if (indexPath.row == 4)
        {
            var customCell:NALabel_Text_IconCell =  tableView.dequeueReusableCellWithIdentifier("NALabel_Text_IconCell") as! NALabel_Text_IconCell
            // customCell.imgCover
            customCell.title.text = "地点"
            
            
            return customCell;
        }
            
        else  if (indexPath.row == 5)
        {
            var customCell:NALabel_WebViewCell =  tableView.dequeueReusableCellWithIdentifier("NALabel_WebViewCell") as! NALabel_WebViewCell
            // customCell.imgCover
            customCell.myText.text = "dasdfasdf"
            
            
            return customCell;
        }
        
        return cell;
        
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
