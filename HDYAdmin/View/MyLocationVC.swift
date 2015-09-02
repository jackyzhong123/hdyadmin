//
//  MyLocationVC.swift
//  HDYAdmin
//
//  Created by Sky on 15/9/1.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit

class MyLocationVC: RootVC ,UITableViewDelegate,UITableViewDataSource {
    
    
    //MARK: 页面变量
    var listData:Array<LocationDetail>=[]
    let cellIdentifier:String = "Cell"
    @IBOutlet weak var tableView: UITableView!
    var IsFromHome = true
    
    //MARK: 页面生存周期
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="地点列表";
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.httpPostApi(AppConfig.Url_MyLocationList, body: nil, tag: 11)
    }
    
    //MARK: 按钮点击事件
    override func ButtonTap(tag: Int) {
        
    }
    
    
    //MARK: 网络调用返回
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
        
        if (tag==11)
        {
            var jsonData:NSArray = response.objectForKey("data") as! NSArray
            listData = []
            for obj in jsonData
            {
                listData.append(LocationDetail(dict: obj as! NSDictionary))
            }
            self.tableView.reloadData()
            
        }
        
        
    }
    
    
    //MARK: Table数据绑定
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (IsFromHome)
        {
             var vc:LocationDetailVC  = UIHelper.GetVCWithIDFromStoryBoard(.Main, viewControllerIdentity: "LocationDetailVC") as! LocationDetailVC
            vc.location = self.listData [indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }else
        {
            NSNotificationCenter.defaultCenter().postNotificationName(AppConfig.NF_SelectLocation, object:  self.listData [indexPath.row] , userInfo:nil);
            self.navigationController?.popViewControllerAnimated(true);

            }
        
       
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell =  tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! UITableViewCell
        cell.textLabel?.text = listData [indexPath.row].LocationName
        return cell;
    }
    
    
}
