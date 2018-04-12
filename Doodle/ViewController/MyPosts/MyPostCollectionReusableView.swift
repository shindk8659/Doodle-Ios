//
//  TestCollectionReusableView.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 8..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import UIKit

class MyPostCollectionReusableView: UICollectionReusableView {
    
    
    
    
    let token = UserDefaults.standard.string(forKey: "token")
    let mypostViewController = MyPostViewController()
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileBackground: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var doodleCountLabel: UILabel!
    @IBOutlet weak var scrapCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var showMyPostBtn: UIButton!
    @IBOutlet weak var showSavePostBtn: UIButton!
    
   var flag = 0
    
    override func awakeFromNib() {
    }
    
    @IBAction func showMyPost(_ sender: Any) {
        let code1="MyPosts"
        let networkManager = MyPostsNetworkManager(self)
        let parameter = ["flag":3]
        
        let header = gsno(token)
        networkManager.netWorkingRequestData(addURL: "/doodle/all", method: .post, parameter: parameter, header: header, code:code1)
        
    }
    
    
    @IBAction func showSavePost(_ sender: Any) {
        
        let code2="MySave"
        let networkManager = MyPostsNetworkManager(self)
        let parameter = ["flag":4]
        
        let header = gsno(token)
        networkManager.netWorkingRequestData(addURL: "/doodle/all", method: .post, parameter: parameter, header: header, code:code2)
        
    }
    
    
    
    
    
}
extension MyPostCollectionReusableView: NetworkCallBack{
    func networkResultData(resultData: Any, code: String) {
        if code == "MyPosts" {
            
            MyPostViewController.imageArray = resultData as! [MyPostList]
            
            collectionView.reloadData()
            
            
            
            
        }else if code == "MySave"{
            print(resultData)
            MyPostViewController.imageArray = resultData as! [MyPostList]
            
            collectionView.reloadData()
            
            
        }
    }
    
    func networkFailed(msg: Any?) {
        
    }
    
}



