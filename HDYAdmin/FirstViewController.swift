//
//  FirstViewController.swift
//  HDYAdmin
//
//  Created by haha on 15/8/31.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit

class FirstViewController: RootVC ,UICollectionViewDataSource ,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    @IBOutlet var lbNickName: UILabel!
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    let myConfig=[
        ["name":"创建活动","targetVC":"AddActivityVC"],
        ["name":"活动一览","targetVC":"MyActivityVC"],
        ["name":"专辑一览","targetVC":"MyAlbumListVC"],
        ["name":"地点一览","targetVC":"MyLocationVC"],
        ["name":"人员管理","targetVC":"MyPeopleVC"]
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.lbNickName.text = AppConfig.sharedAppConfig.NickName
        self.title = "首页"
        
        self.collectionView.delegate = self
        self.collectionView!.dataSource = self
        
    
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myConfig.count;
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var mycell : homeFuncViewCell = self.collectionView!.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! homeFuncViewCell
        
       // mycell.awakeFromNib();
        
        var index = indexPath.row;
        var photoItem:NSDictionary! = myConfig[index] as NSDictionary
        mycell.lbFuncName.text = photoItem.objectForKey("name") as? String
        mycell.imagView.image = UIImage(named: "placeholder.png")
        
        return mycell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        var  rx:CGRect = UIScreen.mainScreen().bounds
        return CGSizeMake(rx.width/3 - 1, rx.width/3 - 1)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        
        
        
        var index = indexPath.row;
        var photoItem:NSDictionary! = myConfig[index] as NSDictionary
        var vc:UIViewController  = UIHelper.GetVCWithIDFromStoryBoard(.Main, viewControllerIdentity: photoItem["targetVC"] as! String)
        //  self.presentViewController(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

