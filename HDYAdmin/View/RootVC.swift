//
//  RootVC.swift
//  HDYAdmin
//
//  Created by haha on 15/9/1.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit

class RootVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.translucent = false

        self.navigationController?.navigationBar.hidden = false
      

        RenderDetail()
        
    }
    
    override func viewDidAppear(animated: Bool) {
    
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() 
    }
    
    
    @IBAction func btnPageTapped(sender: AnyObject) {
        var tag = (sender as! UIButton).tag
        ButtonTap(tag)
    }
    
    func ButtonTap(tag:Int)
    {
        
    }
    
    func RenderDetail()
    {
        
    }
    
    
    //MARK: Table数据绑定
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    

    
    
    func syncUserInfo()
    {
        self.httpGetApi(AppConfig.Url_getProfile, tag: 700)
    }
    
    
    

    // MARK: - 网络访问
    func generateRequest(relative:String)->NSMutableURLRequest
    {
        var oriUrl = AppConfig.SERVICE_ROOT_PATH + relative
        var strUrl = oriUrl.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        var url:NSURL = NSURL(string: strUrl!)!
        var token = AppConfig.sharedAppConfig.getAuthorizationString()
        
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        //添加请求header
        
        request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        NSLog("Request URL: %@", url);
        NSLog("Request Authorization: %@", token);
        return request;
    }
    
    
    func httpPostApi(apiname:String,body:AnyObject?,tag:Int)
    {
        
        var request:NSMutableURLRequest = self.generateRequest(apiname);
        request.HTTPMethod = "POST";
        
        if (body != nil)
        {
            request.HTTPBody = NSJSONSerialization.dataWithJSONObject(body!, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
        }
        
        
        
        
        //跳过证书认证
        var securityPolicy : AFSecurityPolicy = AFSecurityPolicy(pinningMode: AFSSLPinningMode.None)
        securityPolicy.allowInvalidCertificates = true;
        //创建请求操作
        var operation:AFHTTPRequestOperation = AFHTTPRequestOperation(request: request);
        //设置安全级别
        operation.securityPolicy = securityPolicy;
        
        operation.setCompletionBlockWithSuccess({
            (operation:AFHTTPRequestOperation! , responseObject:AnyObject!) in
            
            self.handleHttpResponse(responseObject!, tag: tag)
            
            },
            failure: {
                (operation:AFHTTPRequestOperation! , error:NSError!) in
                
                var statusCode = operation.response?.statusCode
                if statusCode==401
                {
                    AppConfig.sharedAppConfig.userLogout()
                }else
                {
                    self.requestDataFailed("服务器有错误")
                }

                
        })
        operation.start()
    }
    
    func httpGetApi(apiname:String,tag:Int)
    {
        
        
        
        
        var request:NSMutableURLRequest = self.generateRequest(apiname);
        request.HTTPMethod = "GET";
        
        //跳过证书认证
        var securityPolicy : AFSecurityPolicy = AFSecurityPolicy(pinningMode: AFSSLPinningMode.None)
        securityPolicy.allowInvalidCertificates = true;
        //创建请求操作
        var operation:AFHTTPRequestOperation = AFHTTPRequestOperation(request: request);
        //设置安全级别
        operation.securityPolicy = securityPolicy;
        
        operation.setCompletionBlockWithSuccess({
            (operation:AFHTTPRequestOperation! , responseObject:AnyObject!) in
            
            if (tag == 700)
            {
                
                
                AppConfig.sharedAppConfig.syncUserInfo(responseObject)
                return
            }
            
            self.handleHttpResponse(responseObject, tag: tag)
            
            },
            failure: {
                (operation:AFHTTPRequestOperation! , error:NSError!) in
                
                var statusCode = operation.response?.statusCode
                if statusCode==401
                {
                    AppConfig.sharedAppConfig.userLogout()
                }else
                {
                     self.requestDataFailed("服务器有错误")
                }
               
                
                
           //
                
        })
        operation.start()
    }

    func uploadImage(imageData:NSData,tag:Int)
    {
        
        var request:NSMutableURLRequest = self.generateRequest(AppConfig.Url_uploadImage);
        request.HTTPMethod = "POST";
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData;//NSURLRequestReloadIgnoringLocalCacheData
        request.HTTPBodyStream = NSInputStream(data: imageData);
        request.timeoutInterval = 100
        //        request.HTTPBody = imageData;
        
        //        	fileEntity.setContentType("application/octet-stream");
        
        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        //跳过证书认证
        var securityPolicy : AFSecurityPolicy = AFSecurityPolicy(pinningMode: AFSSLPinningMode.None)
        securityPolicy.allowInvalidCertificates = true;
        //创建请求操作
        var operation:AFHTTPRequestOperation = AFHTTPRequestOperation(request: request);
        //设置安全级别
        operation.securityPolicy = securityPolicy;
        
        operation.setCompletionBlockWithSuccess({
            (operation:AFHTTPRequestOperation! , responseObject:AnyObject!) in
            
            self.handleHttpResponse(responseObject, tag: tag)
            
            },
            failure: {
                (operation:AFHTTPRequestOperation! , error:NSError!) in
                
                var statusCode = operation.response?.statusCode
                if statusCode==401
                {
                    AppConfig.sharedAppConfig.userLogout()
                }else
                {
                    self.requestDataFailed("服务器有错误")
                }

                
        })
        operation.start()
    }

    func handleHttpResponse(body:AnyObject,tag:Int)
    {
    
        
        var varData = body as! NSData;
        let dataDir:NSDictionary =  NSJSONSerialization.JSONObjectWithData(varData, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
        
        if(dataDir.count == 0 || dataDir.objectForKey("Code") == nil)
        {
            self.requestDataFailed("网络异常,无效的响应.")
            return ;
        }
        var strCode = dataDir.objectForKey("Code") as! Int
        if(strCode == 10000)//code为1000正常的响应
        {
            var strDetail:AnyObject = dataDir.objectForKey("Detail")!
            self.requestDataComplete(strDetail, tag: tag)
        }
        else if(strCode == 20000)//Code为20000,token令牌失效
        {
            if(AppConfig.sharedAppConfig.isUserLogin())
            {
                AppConfig.sharedAppConfig.userLogout()
            }
            return
        }
        else
        {
            var strErr = dataDir.objectForKey("Message") as! String
            self.requestDataFailed(strErr)
        }
        
    }

    
    func requestDataComplete(response:AnyObject,tag:Int)
    {
        
    }
    func requestDataFailed(error:String)
    {
        SVProgressHUD.showErrorWithStatusWithBlack(error)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
