//
//  UserPostViewController.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 11..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//
import UIKit
import SwiftyJSON

class UserPostViewController: UIViewController {
    
    var userpost : UserPostResult?
    var userpostinfo : UserPostInfo?
    var userpostlist : [UserPostList] = []
    
    var startindex: Int = 0
    var userindex : Int = 0
    
    let token = UserDefaults.standard.string(forKey: "token")
    
    @IBOutlet weak var postlistcollectionView: UICollectionView!
    @IBOutlet var shadowView: UIView!
    
    override func viewDidLoad() {
        
        
        let networkManager = UserPostsNetworkManager(self)
        let header = gsno(token)
        networkManager.netWorkingRequestUserPostData(usridx: userindex ,header : header)
        setNaviBar()
        shadowView.layer.shadowRadius = 3
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowColor = UIColor.init(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0).cgColor
        shadowView.layer.shadowOpacity = 0.5
        postlistcollectionView.isScrollEnabled = true
        postlistcollectionView.dataSource = self
        postlistcollectionView.delegate = self
        
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let networkManager = UserPostsNetworkManager(self)
        let header = gsno(token)
        networkManager.netWorkingRequestUserPostData(usridx: userindex ,header : header)

    }
    
    func setNaviBar() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.title = ""
    }
    
}
extension UserPostViewController: NetworkCallBack{
    func networkResultData(resultData: Any, code: String) {
        if code == "200" {
            
            userpost = resultData as? UserPostResult
            userpostlist = (userpost?.doodle)!
            userpostinfo = userpost?.user
            
            postlistcollectionView.reloadData()
            
        }
    }
   
    
}

extension UserPostViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userpostlist.count
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let listheaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "userHeader", for: indexPath) as! UserPostCollectionReusableView
        
        
        listheaderView.profileImg.imageFromUrl(gsno(userpostinfo?.profile), defaultImgPath: "")
        listheaderView.nameLabel.text = userpostinfo?.nickname
        listheaderView.descriptionLabel.text = userpostinfo?.description
        listheaderView.scrapCountLabel.text = String(gino(userpostinfo?.scrap_count))
        listheaderView.doodleCountLabel.text = String(gino(userpostinfo?.doodle_count))
        
        
        return listheaderView
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userBoxCell", for: indexPath) as! UserPostCollectionViewCell
        
        
        
        cell.img.imageFromUrl(gsno(userpostlist[indexPath.item].image), defaultImgPath: "")
        
        
        return cell
        
    }
    
    
    
    
    
}
extension UserPostViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath){
        
        
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "UserPostListView") as! UserPostListViewController
        startindex = indexPath.item
        nextView.userindex = userindex
        nextView.ListstartIndex = startindex
        nextView.userpost2 =  userpost
        nextView.userpostinfo2 = userpostinfo
        nextView.userpostlist2 = userpostlist
        
        navigationController?.pushViewController(nextView, animated: true)
        
        
        
    }
}


