//
//  NewActivityVC.swift
//  HDYAdmin
//
//  Created by haha on 15/9/7.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit


class NewActivityVC: RootVC ,UITableViewDelegate,UITableViewDataSource {
    
    
    //MARK: 页面变量
    var listData:Array<LocationDetail> = []
    let cellIdentifier:String = "Cell"
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: 页面生存周期
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="新建活动";
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    //MARK: 渲染详细
    override func RenderDetail()
    {
        
    }
    
    //MARK: 按钮点击事件
    override func ButtonTap(tag: Int) {
        
    }
    
    
    //MARK: 网络调用返回
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
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
    
    
}
