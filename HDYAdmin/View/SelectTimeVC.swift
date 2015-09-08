//
//  SelectTimeVC.swift
//  HDYAdmin
//
//  Created by haha on 15/9/7.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit

class SelectTimeVC: RootVC {

    @IBOutlet weak var btnEnd: UIButton!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func ButtonTap(tag: Int) {
        if (tag == 11)
        {
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                
            })
            return
            
        }else if (tag == 12)
        {
            
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
             
            })
           
         var timeModel = TimeModel(startTime: btnStart.titleLabel!.text!,endTime: btnEnd.titleLabel!.text!)
         
        NSNotificationCenter.defaultCenter().postNotificationName(AppConfig.NF_SelectTime, object: timeModel  , userInfo:nil);
         
        //    self.navigationController?.popViewControllerAnimated(true);
        
        }else if (tag == 21)
        {
            btnStart.setTitle(getDate(), forState: UIControlState.Normal)
            
            
        }else if (tag == 22)
        {
             btnEnd.setTitle(getDate(), forState: UIControlState.Normal)
             
        }
        
    }
    func getDate() ->String
    {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm"
        let d = formatter.stringFromDate(self.datePicker.date)
        return d

    }
    
    
    
}
