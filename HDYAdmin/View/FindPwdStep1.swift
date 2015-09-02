//
//  FindPwdStep1.swift
//  HDYAdmin
//
//  Created by Sky on 15/9/1.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit

class FindPwdStep1: RootVC ,UIAlertViewDelegate{

    @IBOutlet weak var txtInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
 self.title = "忘记密码"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func  viewDidAppear(animated: Bool) {
        
        txtInput.frame = CGRectMake(txtInput.frame.origin.x, txtInput.frame.origin.y, txtInput.frame.width,44)
    }
    
    
    @IBAction func btnActionTapped(sender: AnyObject) {
        
        if (self.txtInput.text.length != 11) {
            return;
        }
        
        self.view.endEditing(true)
        var alert = UIAlertView()
        alert.title = "确认手机号码"
        alert.message = "我们将发送验证码短信到这个号码:\r\n" + self.txtInput.text
        alert.addButtonWithTitle("取消")
        alert.addButtonWithTitle("确定")
        alert.delegate = self;
        alert.show()
    }

    //MARK alertView Delegate
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if(buttonIndex == 0)//cancel
        {
            
        }
        else
        {
            SVProgressHUD.showWithStatusWithBlack("验证码短信发送中...")
            var strapiName = self.txtInput.text
             self.httpGetApi("api/Login/sendSMS?mobile=\(strapiName)", tag: 11)
        }
    }
    
    //MARK WebRequestDelegate
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
        if(tag == 11)
        {
            SVProgressHUD.showSuccessWithStatusWithBlack("验证码已发送成功");
            var vc:RegisterStep2VC = UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "RegisterStep2VC") as! RegisterStep2VC
            vc.strPhone = txtInput.text.trim();
            vc.isFromFindPwd = true;
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
