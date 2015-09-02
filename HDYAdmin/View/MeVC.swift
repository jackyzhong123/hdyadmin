//
//  MeVCViewController.swift
//  HDYAdmin
//
//  Created by Sky on 15/9/1.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit

class MeVC: RootVC ,UITableViewDataSource,UITableViewDelegate
{
    
    //MARK: 页面变量
    @IBOutlet var tableView: UITableView!
    let  headCell = "CellHeader"
    let  generalCell = "Cell"
    let iconArr = ["setting_myCardList"]
    let titleArr = ["注销"]
    
    
    //MARK: 页面生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
   
   
      
    //MARK: 按钮点击
    @IBAction func btnTapped(sender: AnyObject) {
        
        var tag = (sender as! UIButton).tag
        if (tag==10)
        {
            
            
            
        }
    }
    
    //MARK: 网络调用
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
        
    }
    
    
    //MARK: 数据绑定
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0)
        {
            return 68
        }
        return 44
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0)
        {
            return 1
        }
        else
        {
            return self.iconArr.count
        }
    }
    
  
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0)
        {
            var headcell:HeadAreaCell = self.tableView.dequeueReusableCellWithIdentifier(self.headCell) as! HeadAreaCell
            
            headcell.lbName.text = AppConfig.sharedAppConfig.NickName
            
            headcell.imgCover!.sd_setImageWithURL(NSURL(string:AppConfig.sharedAppConfig.Portrait)!, placeholderImage: UIImage(named: "placeholder.png"))
            
            var layer:CALayer = headcell.imgCover.layer
            layer.cornerRadius = 10
            layer.masksToBounds = true
            return headcell;
        }
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier(self.generalCell) as! UITableViewCell
        if (indexPath.section == 1 )
        {
            cell.textLabel?.text = titleArr [indexPath.row]
            cell.imageView?.image = UIImage(named: iconArr[indexPath.row])
            
            
            return cell;
            
            
        }
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.section == 0 )
        {
            //开始上传图片
            return
        }else
        {
            //注销
            AppConfig.sharedAppConfig.userLogout()
            var vc = UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "loginNavigation")
            
            self.view.window?.rootViewController = vc

        }
        
        
    }
    
    
    
    
}
