//
//  MyAlbumListVC.swift
//  HDYAdmin
//
//  Created by Sky on 15/9/1.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit

class MyAlbumListVC:  RootVC,UICollectionViewDelegate,UICollectionViewDataSource  {

    var listData:Array<AlbumDetail>=[]
    let resuseIdentifier:String = "Cell"
    var IsFromHome = true

     @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="专辑列表";
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIHelper.SetNaviBarRightItemWithName(self, action: "toggleRightMenu:", strName: "新增")
        
        if(listData.count==0 )
        {
            //   SVProgressHUD.showWithStatusWithBlack("请稍后...")
        }
        let Parameters=[]
        self.httpPostApi(AppConfig.Url_getMyAlbumList, body: Parameters, tag: 10)
    }
    
    
    func toggleRightMenu(sender:AnyObject)
    {
        //   NSLog("%@", AddNewAlbumVC.description())
        
        var vc:UIViewController  = UIHelper.GetVCWithIDFromStoryBoard(.Main, viewControllerIdentity: "AddNewAlbumVC")
        //  self.presentViewController(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listData.count;
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var mycell : myAlbumListCell = self.collectionView!.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! myAlbumListCell
        
        
        
        var index = indexPath.row;
        
        
        var obj:AlbumDetail = self.listData[indexPath.row] as AlbumDetail
        
        mycell.lbAlbumName.text=obj.AlbumName
        //  mycell.imageV
        
        mycell.imageView!.sd_setImageWithURL(NSURL(string: obj.AlbumIcon)!, placeholderImage: UIImage(named: "placeholder.png"))
        
        
        mycell.AlbumId=obj.Albumid
        
        
        return mycell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        var  rx:CGRect = UIScreen.mainScreen().bounds
        return CGSizeMake(rx.width/3 - 2, rx.width/3+30 - 2)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if (IsFromHome)
        {
            
            
        }else
        {
            NSNotificationCenter.defaultCenter().postNotificationName(AppConfig.NF_SelectAlbum, object:  self.listData [indexPath.row] , userInfo:nil);
           self.navigationController?.popViewControllerAnimated(true);
        }
    }
    
    
    //MARK WebRequestDelegate
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
        SVProgressHUD.dismiss();
        if (tag == 10) {
            if let dataArray = response as? NSArray{
                listData.removeAll(keepCapacity: false)
                
                for itemObj in dataArray
                {
                    if let itemDic = itemObj as? NSDictionary{
                        var data=AlbumDetail(dict: itemDic)
                        listData.append(data)
                    }
                }
              //  dataMgr.saveMyCardList(dataArray);
                self.collectionView.reloadData()
            }
        }
    }
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
