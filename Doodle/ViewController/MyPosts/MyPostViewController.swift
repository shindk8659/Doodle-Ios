//
//  TestViewController.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 8..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import UIKit
import SwiftyJSON

class MyPostViewController: UIViewController {
    @IBOutlet var shadowView: UIView!
    
    static var imageArray : [MyPostList] = []
    var profileData : ProfileList?
    let postlistindex = PostListViewController()
    var token = UserDefaults.standard.string(forKey: "token")
    var startIndex: Int = 0
    var btnFlag = 0
    @IBOutlet var myPostView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        let networkManager = MyPostsNetworkManager(self)
        let parameter1 = ["flag":3]
        let code1="MyPosts"
        let code2="MyProfile"
        let header = gsno(token)
        networkManager.netWorkingRequestData(addURL: "/doodle/all", method: .post, parameter: parameter1, header: header, code:code1)
        
        networkManager.netWorkingRequestProfile(addURL: "/users", method: .get, header: header, code:code2)
        setNaviBar()
        shadowView.layer.shadowRadius = 3
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowColor = UIColor.init(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0).cgColor
        shadowView.layer.shadowOpacity = 0.5
        
        collectionView.isScrollEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        let networkManager = MyPostsNetworkManager(self)
        
        let code1="MyPosts"
        let code2="MyProfile"
        let header = gsno(token)
       
        if btnFlag == 0 {
            let parameter1 = ["flag":3]
             networkManager.netWorkingRequestData(addURL: "/doodle/all", method: .post, parameter: parameter1, header: header, code:code1)
        } else {
            let parameter1 = ["flag":4]
            networkManager.netWorkingRequestData(addURL: "/doodle/all", method: .post, parameter: parameter1, header: header, code:code1)
        }
        networkManager.netWorkingRequestProfile(addURL: "/users", method: .get, header: header, code:code2)
        
        //collectionView.reloadData()
        
    }
    func setNaviBar() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.title = "나의 글"
    }
    
    @objc func setNavigationTitleMyFeed(sender: UIButton) {
        self.navigationItem.title = "나의 글"
        btnFlag = 0
        
    }
    @objc func setNavigationTitleScrapFeed(sender: UIButton) {
        self.navigationItem.title = "담은 글"
        btnFlag = 1
    }
    
}
extension MyPostViewController: NetworkCallBack{
    func networkResultData(resultData: Any, code: String) {
        if code == "MyPosts" {
            
            MyPostViewController.imageArray = resultData as! [MyPostList]
            
            
            collectionView.reloadData()
            
            
            
        }
        if code == "MyProfile"{
            profileData = resultData as? ProfileList
            
            collectionView.reloadData()
        }
    }
    
}
extension MyPostViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  MyPostViewController.imageArray.count
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! MyPostCollectionReusableView
        
        
        if btnFlag == 1{
            headerView.showSavePostBtn.isHighlighted = false
            headerView.showMyPostBtn.isHighlighted = true
            //headerView.showMyPostBtn.setTitleColor(UIColor.black, for:.highlighted)
            //headerView.showMyPostBtn.setBackgroundImage(nil, for: .highlighted)
            
            
        } else {
            print("flag = 0")
            headerView.showSavePostBtn.isHighlighted = true
            headerView.showMyPostBtn.isHighlighted = false
            //headerView.showSavePostBtn.setTitleColor(UIColor.black, for:.highlighted)
            //headerView.showSavePostBtn.setBackgroundImage(nil, for: .highlighted)
        }
        headerView.nameLabel.text = profileData?.nickname
        headerView.descriptionLabel.text = profileData?.description
        headerView.doodleCountLabel.text = String(gino(profileData?.doodle_count))
        headerView.scrapCountLabel.text = String(gino(profileData?.scrap_count))
        headerView.profileImg.imageFromUrl(gsno(profileData?.image), defaultImgPath: "")
        
        
        let profileImg = gsno(profileData?.image)
        let profileDescription = gsno(profileData?.description)
        UserDefaults.standard.set(profileImg, forKey: "profileImg")
        UserDefaults.standard.set(profileDescription, forKey: "profileDescription")
        UserDefaults.standard.synchronize()
        
        headerView.nameLabel.sizeToFit()
        headerView.doodleCountLabel.sizeToFit()
        headerView.scrapCountLabel.sizeToFit()
        
        headerView.showMyPostBtn.addTarget(self, action: #selector(setNavigationTitleMyFeed(sender:)), for: .touchUpInside)
        headerView.showSavePostBtn.addTarget(self, action: #selector(setNavigationTitleScrapFeed(sender:)), for: .touchUpInside)
        
        return headerView
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoxCell", for: indexPath) as! MyPostCollectionViewCell
        
        let image = MyPostViewController.imageArray[indexPath.item]
        
        cell.img.imageFromUrl(gsno((image.image)), defaultImgPath: "")
        return cell
        
    }
    
    
}

extension MyPostViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath){
        
        if  (profileData?.nickname == MyPostViewController.imageArray[indexPath.item].nickname){
            let storyboard: UIStoryboard = self.storyboard!
            let nextView = storyboard.instantiateViewController(withIdentifier: "PostListView") as! PostListViewController
            
            startIndex = indexPath.item
            nextView.ListstartIndex = startIndex
            
            nextView.profileList = profileData
            navigationController?.pushViewController(nextView, animated: true)
        }
        else{
            let storyboard: UIStoryboard = self.storyboard!
            let nextView = storyboard.instantiateViewController(withIdentifier: "SaveListView") as! SaveListViewController
            
            startIndex = indexPath.item
            nextView.ListstartIndex = startIndex
            
            navigationController?.pushViewController(nextView, animated: true)
            
        }
        
    }
}

