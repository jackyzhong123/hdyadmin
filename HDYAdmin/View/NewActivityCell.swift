//
//  NewActivityCell.swift
//  HDYAdmin
//
//  Created by haha on 15/9/7.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit


class NA_ImageCell: UITableViewCell {
    
 
    
    @IBOutlet var imgCover: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

class NALabel_TextCell: UITableViewCell {
    
    
    
    @IBOutlet var title :UILabel!
    @IBOutlet var myText:UITextField!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

class NALabel_Text_IconCell: UITableViewCell {
    
    
    
    @IBOutlet var title :UILabel!
    @IBOutlet var myText:UITextField!
    @IBOutlet var myButton:UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

class NALabel_WebViewCell: UITableViewCell {
    
    
    
    @IBOutlet var myText:UITextView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}


