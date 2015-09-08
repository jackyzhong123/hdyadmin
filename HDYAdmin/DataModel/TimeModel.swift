//
//  TimeModel.swift
//  HDYAdmin
//
//  Created by haha on 15/9/8.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit

class TimeModel: NSObject {
    var startTime: String?
    var endTime: String?
    
    
    init(startTime: String, endTime: String) {
        self.startTime = startTime
        self.endTime  = endTime
  
    }
}
