//
//  SaveViewController.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 10..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import UIKit

class SaveListViewController: UIViewController {
    
    var postList : [MyPostList] = []
    
    var ListstartIndex:Int = 0
    
    var likeIndex = 0
    var scrapIndex = 0
    
    var token = UserDefaults.standard.string(forKey: "token")
    var myNickname = UserDefaults.standard.string(forKey: "nickname")
    
    @IBOutlet weak var postlistcollectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        let code1="Save"
        let networkManager = MyPostsNetworkManager(self)
        let parameter = ["flag":4]
        
        let header = gsno(token)
        networkManager.netWorkingRequestData(addURL: "/doodle/all", method: .post, parameter: parameter, header: header, code:code1)
        
        setNaviBar()
        postlistcollectionView.isScrollEnabled = true
        postlistcollectionView.dataSource = self
        postlistcollectionView.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        let code1="MySave"
        let networkManager = MyPostsNetworkManager(self)
        let parameter = ["flag":4]
        
        let header = gsno(token)
        networkManager.netWorkingRequestData(addURL: "/doodle/all", method: .post, parameter: parameter, header: header, code:code1)
        
    }
    func setNaviBar() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.title = "담은 글"
    }
    
    
    
}
extension SaveListViewController: NetworkCallBack{
    func networkResultData(resultData: Any, code: String) {
        if code == "MySave" {
            
            postList = resultData as! [MyPostList]
            
            
            postlistcollectionView.reloadData()
            
        }
        
    
    
    }}
extension SaveListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postList.count - ListstartIndex
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath ) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListBoxCell1", for: indexPath) as! SaveListCollectionViewCell
        let Data = postList[indexPath.item + ListstartIndex ]
       
        
        cell.postListImg.imageFromUrl(gsno(Data.image), defaultImgPath: "")
        cell.postDateLabel.text = Data.created
        cell.nicknameLabel.setTitle(gsno(Data.nickname),for: .normal)
        cell.gongGam.setTitle("공감 \(gino(Data.like_count))", for: .normal)
        cell.comment.setTitle("댓글 \(gino(Data.comment_count))", for: .normal)
        cell.scrap.setTitle("담아감 \(gino(Data.scrap_count))", for: .normal)
        if Data.like == Data.idx {
            print(gino(Data.like_count))
            cell.gongGam.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 1.0), for: .normal)
            cell.gongGam.titleLabel?.layer.shadowColor = UIColor.init(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0).cgColor
            cell.gongGam.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.gongGam.titleLabel?.layer.shadowRadius = 1
            cell.gongGam.titleLabel?.layer.shadowOpacity = 0.8
        } else  {
            cell.gongGam.setTitleColor(UIColor.init(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0), for: .normal)
            cell.gongGam.titleLabel?.layer.shadowColor = UIColor.clear.cgColor
            cell.gongGam.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.gongGam.titleLabel?.layer.shadowRadius = 1
            cell.gongGam.titleLabel?.layer.shadowOpacity = 0.8
        }
        if Data.scrap == Data.idx {
            cell.scrap.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 1.0), for: .normal)
            cell.scrap.titleLabel?.layer.shadowColor = UIColor.init(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0).cgColor
            cell.scrap.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.scrap.titleLabel?.layer.shadowRadius = 1
            cell.scrap.titleLabel?.layer.shadowOpacity = 0.8
        } else {
            cell.scrap.setTitleColor(UIColor.init(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0), for: .normal)
            cell.scrap.titleLabel?.layer.shadowColor = UIColor.clear.cgColor
            cell.scrap.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.scrap.titleLabel?.layer.shadowRadius = 1
            cell.scrap.titleLabel?.layer.shadowOpacity = 0.8
        }
        
        cell.gongGam.tag = indexPath.item + ListstartIndex
        cell.gongGam.addTarget(self, action: #selector(likeUnlike(sender:)), for: .touchUpInside)
        cell.scrap.tag = indexPath.item + ListstartIndex
        cell.scrap.addTarget(self, action: #selector(scrapUnscrap(sender:)), for: .touchUpInside)
        
        cell.comment.tag = indexPath.item + ListstartIndex
        cell.comment.addTarget(self, action: #selector(goToComment(sender:)), for: .touchUpInside)
       
        cell.nicknameLabel.tag = indexPath.item + ListstartIndex
        cell.nicknameLabel.addTarget(self, action: #selector (goToProfile(sender:)), for: .touchUpInside)
        
        cell.EditBtn.addTarget(self, action: #selector(editbuttonTapped(sender:)), for: .touchUpInside)
        
        cell.nicknameLabel.sizeToFit()
        cell.postDateLabel.sizeToFit()
        return cell
        
        
    }
    @objc func editbuttonTapped(sender:UIButton ) {
        
        
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        
        
        let somethingAction = UIAlertAction(title: "내 폰으로 저장하기", style: .default, handler: {(alert: UIAlertAction!) in print("여기 함수 넣으면됨")})
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in print("cancel")})
        
        alertController.addAction(somethingAction)
        alertController.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion:{})
            
        }
    }
    @objc func likeUnlike(sender: UIButton) {
        let model = AppreciateManager(self)
        likeIndex = sender.tag
        
        let idx = postList[likeIndex].idx
        if postList[likeIndex].like == nil {
            print("like")
            postList[likeIndex].like_count = postList[likeIndex].like_count! + 1
            sender.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 1.0), for: .normal)
            sender.titleLabel?.layer.shadowColor = UIColor.init(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0).cgColor
            sender.setTitle("공감 \(gino(postList[likeIndex].like_count))", for: .normal)
            postList[likeIndex].like = idx
            model.likeUnlike(like: "like", idx: gino(idx), token: gsno(token))
        } else {
            print("unlike")
            postList[likeIndex].like_count = postList[likeIndex].like_count! - 1
            sender.setTitleColor(UIColor.init(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0), for: .normal)
            sender.titleLabel?.layer.shadowColor = UIColor.clear.cgColor
            sender.setTitle("공감 \(gino(postList[likeIndex].like_count))", for: .normal)
            postList[likeIndex].like = nil
            model.likeUnlike(like: "unlike", idx: gino(idx), token: gsno(token))
        }
    }
    @objc func scrapUnscrap(sender: UIButton) {
        
        let model = AppreciateManager(self)
        scrapIndex = sender.tag
        let idx = postList[scrapIndex].idx
        if postList[scrapIndex].nickname == myNickname {
            simpleAlert(title: "담아가기", msg: "자신의 글은 담을 수 없습니다.")
            return
        }
        if postList[scrapIndex].scrap == nil {
            postList[scrapIndex].scrap_count = postList[scrapIndex].scrap_count! + 1
            sender.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 1.0), for: .normal)
            sender.titleLabel?.layer.shadowColor = UIColor.init(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0).cgColor
            sender.setTitle("담아감 \(gino(postList[scrapIndex].scrap_count))", for: .normal)
            postList[scrapIndex].scrap = idx
            model.scrapUnscrap(scrap: "scrap", idx: gino(idx), token: gsno(token))
        } else {
            postList[scrapIndex].scrap_count = postList[scrapIndex].scrap_count! - 1
            sender.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 1.0), for: .normal)
            sender.titleLabel?.layer.shadowColor = UIColor.clear.cgColor
            sender.setTitle("담아감 \(gino(postList[scrapIndex].scrap_count))", for: .normal)
            postList[scrapIndex].scrap = nil
            model.scrapUnscrap(scrap: "unscrap", idx: gino(idx), token: gsno(token))
        }
    }
    
    @objc func goToComment(sender:UIButton ) {

        guard let nextView = storyboard?.instantiateViewController(withIdentifier: "commentView") as? CommentViewController else {return}
        
        nextView.commentindex = gino(postList[sender.tag].idx)
        navigationController?.pushViewController(nextView, animated: true)
        
        
    }
    
    @objc func goToProfile(sender:UIButton ) {
        
        
        guard let nextView = storyboard?.instantiateViewController(withIdentifier: "userpost") as? UserPostViewController else{return}
        
        nextView.userindex = gino(postList[sender.tag].user_idx)
        navigationController?.pushViewController(nextView, animated: true)
        
        
    }
    
    
}
extension SaveListViewController: UICollectionViewDelegateFlowLayout {
    
}

