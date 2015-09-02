//
//  TableSampleController.swift
//  HDYAdmin
//
//  Created by Sky on 15/9/2.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit


class TableSampleVC: RootVC ,UITableViewDelegate,UITableViewDataSource {
    
    
    //MARK: 页面变量
    var listData:Array<LocationDetail> = []
    let cellIdentifier:String = "Cell"
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: 页面生存周期
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="地点列表";
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
    
    
    //MARK: 表格选项
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell =  tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! UITableViewCell
        return cell;
    }
    
    
}
