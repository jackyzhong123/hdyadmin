//
//  AddNewPlaceVC.swift
//  HDYAdmin
//
//  Created by Sky on 15/9/7.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit
import MapKit

class AddNewPlaceVC: RootVC,MKMapViewDelegate,CLLocationManagerDelegate {
    
    
    @IBOutlet var LocationAddress: UITextView!
    @IBOutlet var txtPlaceName: UITextField!
    @IBOutlet var mapView: MKMapView!
    
    //MARK: 页面变量
    
    
    var locationManager:CLLocationManager!
    var latitude:CLLocationDegrees = 0.0
    var longitude:CLLocationDegrees = 0.0
    
    
    
    //MARK: 页面生存周期
    override func viewDidLoad() {
       IsNeedDoneButton = true
        super.viewDidLoad()
        
        UIHelper.SetNaviBarRightItemWithName(self, action: "toggleRightMenu:", strName: "保存")
        
    }
    
    
    
    func toggleRightMenu(sender: AnyObject)
    {
        let parameters = [
        "AddressName": self.LocationAddress.text,
            "LocationName":self.txtPlaceName.text,
            "latitude":self.latitude,
            "longitude":self.longitude
        
        
        ]
        self.httpPostApi(AppConfig.Url_AddNewLocation, body: parameters, tag: 11)
       
        
    }
    
    //MARK: 渲染详细
    override func RenderDetail()
    {
        self.title="地点详情";
        mapView.mapType = MKMapType.Standard
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        locationManager = CLLocationManager()
        if (locationManager.respondsToSelector("requestAlwaysAuthorization")){
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter  = 100
        
        var mTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapPress:")
        
        self.mapView.addGestureRecognizer(mTap)
        
    }
    
    
    func tapPress (gestureRecognizer:UIGestureRecognizer)
    {
        var touchPoint:CGPoint = gestureRecognizer.locationInView(self.mapView)
        var touchMapCoordinate:CLLocationCoordinate2D = self.mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
        
        mapView.removeAnnotations(mapView.annotations)
        
        
        self.latitude = touchMapCoordinate.latitude
        self.longitude = touchMapCoordinate.longitude
        
        
        let mapPin:MapPin = MapPin(coordinate: touchMapCoordinate,title: "活动地点",subtitle:"")
        
        
        
        mapView.addAnnotation(mapPin)
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.startUpdatingLocation()
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    
    /**
    *  只要定位到用户的位置，就会调用（调用频率特别高）
    *  @param locations : 装着CLLocation对象
    */
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var loc:CLLocation = locations.first as! CLLocation
        var coordinate:CLLocationCoordinate2D = loc.coordinate
        manager.stopUpdatingLocation()
        
        var viewRegion:MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, 10000, 10000)
        
        self.mapView.setRegion(viewRegion, animated: true)
    }
    
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
    }
    
    
    
    
    
    
    
    //MARK: 按钮点击事件
    override func ButtonTap(tag: Int) {
        if (tag == 1 )
        {
            if (LocationAddress.text == nil || LocationAddress.text.length == 0)
            {
                return
            }
            var geocoder:CLGeocoder = CLGeocoder()
           
            
            geocoder.geocodeAddressString(LocationAddress.text, completionHandler: { (placemarks: [AnyObject]!, error:NSError!) -> Void in
                
                
        
                
            })
            
        }
        
        
    }
    
    
    //MARK: 网络调用返回
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
          if(tag == 11)
        {
            self.navigationController?.popViewControllerAnimated(true)
        }
        if (response is NSDictionary)
        {
            
            var jsonData=JSON(response)
            
        }
    }
    
    
    
    
}
