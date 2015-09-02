//
//  TableSampleController.swift
//  HDYAdmin
//
//  Created by Sky on 15/9/2.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit
import MapKit

class LocationDetailVC : RootVC  ,MKMapViewDelegate {
    
    @IBOutlet var mapLocation: MKMapView!
    
    @IBOutlet var lbLocationName: UILabel!
    @IBOutlet var lbLocationAddress: UILabel!
    //MARK: 页面变量
    var location:LocationDetail?
    
    
    
    //MARK: 页面生存周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func RenderDetail()
    {
        self.title="地点详情";
        self.lbLocationName.text = location?.LocationName
        self.lbLocationAddress.text = location?.LocationAddress
        
        mapLocation.mapType=MKMapType.Standard;
        mapLocation.delegate = self;
        
        var coords =     CLLocationCoordinate2D(latitude:(location?.Latitude)! ,longitude:(location?.Longitude)!)
        var title = "活动场地" + (location?.LocationName)!
        let subtitle = (location?.LocationAddress)!
        
        let mapPin:MapPin = MapPin(coordinate: coords,title: title,subtitle:subtitle)
        
        mapLocation.addAnnotation(mapPin)
        var    viewRegion:MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(coords, 10000, 10000);
        mapLocation.setRegion(viewRegion, animated: true)
        
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
