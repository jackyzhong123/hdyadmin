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
    @IBOutlet var txtStart: UITextField!
    
    @IBOutlet var txtEnd: UITextField!
    @IBOutlet var txtAlbum: UITextField!
    
    @IBOutlet var txtActivityDescrition: UITextView!
    @IBOutlet var txtLocation: UITextField!
    
    
    //MARK: 页面生存周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    //MARK: 渲染详细
    override func RenderDetail()
    {
        self.title="添加活动";
        
        
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
