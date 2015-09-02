//
//  TableSampleController.swift
//  HDYAdmin
//
//  Created by Sky on 15/9/2.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit


class ViewSampleVC: RootVC   {
    
    
    //MARK: 页面变量
    
    
    
    //MARK: 页面生存周期
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="地点详情";
   
        
        
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
    
    
    
    
}
