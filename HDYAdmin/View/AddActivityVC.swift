//
//  AddActivityVC.swift
//  HDYAdmin
//
//  Created by Sky on 15/9/2.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit

class AddActivityVC: RootVC {
    
    
    //MARK: 页面变量
    
    @IBOutlet var txtName: UITextField!
    
      @IBOutlet var txtAlbum: UITextField!
    
    @IBOutlet var txtStart: UIButton!
    
    @IBOutlet var txtEnd: UIButton!
    
    
    @IBOutlet var txtActivityDescrition: UITextView!
    @IBOutlet var txtLocation: UITextField!
    
    @IBOutlet var tvDescription: UITextView!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    var albumDetail:AlbumDetail?
    var locationDetail:LocationDetail?
    
    
    @IBAction func btnStart(sender: AnyObject) {
        
        datePicker.hidden = false
    }
    
    
    @IBAction func btnEnd(sender: AnyObject) {
        datePicker.hidden = false
    }
    
    
    //MARK: 页面生存周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    func toggleRightMenu(sender: AnyObject)
    {
        let parameter = [
            "ActivityPost":"",
            "ActivityName":txtName.text,
            "ActivityStart":txtStart.titleLabel?.text,
            "ActivityEnd":txtEnd.titleLabel?.text,
            "Album":txtAlbum.text,
            "Location":txtLocation.text,
            "LocationProxy":txtLocation.text,
            "Description":txtActivityDescrition.text
        ]
        
        self.httpPostApi(AppConfig.Url_AddActivity, body: parameter, tag: 10)
    }
    
    
    //MARK: 渲染详细
    override func RenderDetail()
    {
          UIHelper.SetNaviBarRightItemWithName(self, action: "toggleRightMenu:", strName: "保存")
        self.title="添加活动";
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"selectAlbum:" , name: AppConfig.NF_SelectAlbum, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"selectLocation:" , name: AppConfig.NF_SelectLocation, object: nil)
        
        datePicker.hidden = true
        
    }
    
    func selectLocation(notification:NSNotification) {
        
        self.locationDetail = notification.object as? LocationDetail;
        self.txtLocation.text = locationDetail?.LocationName
        
    }
    
    func selectAlbum(notification:NSNotification) {
        
        self.albumDetail = notification.object as? AlbumDetail;
        self.txtAlbum.text = albumDetail?.AlbumName

    }
    
    //MARK: 按钮点击事件
    override func ButtonTap(tag: Int) {
        if (tag == 11)
        {
            var vc:MyAlbumListVC   = UIHelper.GetVCWithIDFromStoryBoard(.Main, viewControllerIdentity: "MyAlbumListVC") as! MyAlbumListVC
            vc.IsFromHome = false
            
            self.navigationController?.pushViewController(vc, animated: true)

        }else if(tag == 12)
        {
            var vc:MyLocationVC  = UIHelper.GetVCWithIDFromStoryBoard(.Main, viewControllerIdentity: "MyLocationVC") as! MyLocationVC
            vc.IsFromHome = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    //MARK: 网络调用返回
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
        if (response is NSDictionary)
        {
            
            var jsonData=JSON(response)
            if(tag == 10)
            {
                SVProgressHUD.showSuccessWithStatusWithBlack("密码修改成功");
                self.navigationController?.popViewControllerAnimated(true);
            }
            
        }
    }
    
    
    
    
}
