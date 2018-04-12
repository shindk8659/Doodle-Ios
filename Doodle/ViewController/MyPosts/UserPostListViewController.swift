//
//  PostListViewController.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 11..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import UIKit
import SwiftyJSON
import MessageUI

class UserPostListViewController: UIViewController , MFMailComposeViewControllerDelegate{
    let token = UserDefaults.standard.string(forKey: "token")
    let myNickname = UserDefaults.standard.string(forKey: "nickname")
    var userpost2 : UserPostResult?
    var userpostinfo2 : UserPostInfo?
    var userpostlist2 : [UserPostList] = []
    
    var ListstartIndex:Int = 0
    var userindex:Int = 0
    
    var likeIndex = 0
    var scrapIndex = 0
    
    @IBOutlet var shadowView: UIView!
    
    @IBOutlet weak var userpostlistcollectionView: UICollectionView!
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("취소")
        case .saved:
            print("임시저장")
        case .sent:
            print("전송완료")
        default:
            print("전송실패")
        }
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        let networkManager = UserPostsNetworkManager(self)
        let header = gsno(token)
        networkManager.netWorkingRequestUserPostData(usridx: userindex ,header : header)
        setNaviBar()
        
        shadowView.layer.shadowRadius = 3
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowColor = UIColor.init(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0).cgColor
        shadowView.layer.shadowOpacity = 0.5
        userpostlistcollectionView.isScrollEnabled = true
        userpostlistcollectionView.dataSource = self
        userpostlistcollectionView.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
extension UserPostListViewController: NetworkCallBack{
    func networkResultData(resultData: Any, code: String) {
        if code == "200" {
            
            userpost2 = resultData as? UserPostResult
            userpostlist2 = (userpost2?.doodle)!
            userpostinfo2 = userpost2?.user
            
            userpostlistcollectionView.reloadData()
            
        }
    }
    
    
    
}
extension UserPostListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userpostlist2.count - ListstartIndex
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let listheaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "UserListHeader", for: indexPath) as! UserPostListCollectionReusableView
        listheaderView.nameLabel.text = userpostinfo2?.nickname
        listheaderView.profileImg.imageFromUrl(gsno(userpostinfo2?.profile), defaultImgPath: "")
        listheaderView.nameLabel.sizeToFit()
        listheaderView.layer.masksToBounds = true
        return listheaderView
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserListBoxCell", for: indexPath) as! UserPostListCollectionViewCell
        let Data = userpostlist2[indexPath.item + ListstartIndex]
        //let commentindex : Int = gino(Data.idx)
        
        cell.postListImg.imageFromUrl(gsno(Data.image), defaultImgPath: "")
        cell.postDateLabel.text = Data.created
        cell.postDateLabel.sizeToFit()
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
        cell.EditBtn.tag = indexPath.item + ListstartIndex
        cell.EditBtn.addTarget(self, action: #selector(editbuttonTapped(sender:)), for: .touchUpInside)
        
        return cell
        
    }
    
    @objc func editbuttonTapped(sender:UIButton ) {
        
        func mailfunc(){
            if MFMailComposeViewController.canSendMail(){
                print("sdfsdf")
                var reportUserIdx :Int = 0
                var reportIdx:Int = 0
                
                reportIdx = self.userpostlist2[sender.tag].idx!
                reportUserIdx = self.userpostlist2[sender.tag].user_idx!
                
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["shindk8659@naver.com"])
                mail.setSubject("신고합니다.")
                mail.setMessageBody("유저인덱스:\(reportUserIdx),게시물인덱스:\(reportIdx) , 신고합니다.", isHTML: false)
                self.present(mail, animated: true)
            } else {
                let alert = UIAlertController(title: "메일 보내기 실패", message: "메일 어플리케이션에서 메일설정을 해주세요!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print("메일 보내기 실패")
            }
        }
    
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        
        let reportAction = UIAlertAction(title: "신고 하기", style: .default, handler: {(alert: UIAlertAction!) in mailfunc()})
        let somethingAction = UIAlertAction(title: "내 폰으로 저장하기", style: .default, handler: {(alert: UIAlertAction!) in print("여기 함수 넣으면됨")})
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in print("cancel")})
        alertController.addAction(reportAction)
        alertController.addAction(somethingAction)
        alertController.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion:{})
            
        }
    }
    
    @objc func likeUnlike(sender: UIButton) {
        let model = AppreciateManager(self)
        likeIndex = sender.tag
        
        let idx = userpostlist2[likeIndex].idx
        if userpostlist2[likeIndex].like == nil {
            print("like")
            userpostlist2[likeIndex].like_count = userpostlist2[likeIndex].like_count! + 1
            sender.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 1.0), for: .normal)
            sender.titleLabel?.layer.shadowColor = UIColor.init(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0).cgColor
            sender.setTitle("공감 \(gino(userpostlist2[likeIndex].like_count))", for: .normal)
            userpostlist2[likeIndex].like = idx
            model.likeUnlike(like: "like", idx: gino(idx), token: gsno(token))
        } else {
            print("unlike")
            userpostlist2[likeIndex].like_count = userpostlist2[likeIndex].like_count! - 1
            sender.setTitleColor(UIColor.init(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0), for: .normal)
            sender.titleLabel?.layer.shadowColor = UIColor.clear.cgColor
            sender.setTitle("공감 \(gino(userpostlist2[likeIndex].like_count))", for: .normal)
            userpostlist2[likeIndex].like = nil
            model.likeUnlike(like: "unlike", idx: gino(idx), token: gsno(token))
        }
    }
    @objc func scrapUnscrap(sender: UIButton) {
        
        let model = AppreciateManager(self)
        scrapIndex = sender.tag
        let idx = userpostlist2[scrapIndex].idx
        if userpostlist2[scrapIndex].nickname == myNickname {
            simpleAlert(title: "담아가기", msg: "자신의 글은 담을 수 없습니다.")
            return
        }
        if userpostlist2[scrapIndex].scrap == nil {
            userpostlist2[scrapIndex].scrap_count = userpostlist2[scrapIndex].scrap_count! + 1
            sender.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 1.0), for: .normal)
            sender.titleLabel?.layer.shadowColor = UIColor.init(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0).cgColor
            sender.setTitle("담아감 \(gino(userpostlist2[scrapIndex].scrap_count))", for: .normal)
            userpostlist2[scrapIndex].scrap = idx
            model.scrapUnscrap(scrap: "scrap", idx: gino(idx), token: gsno(token))
        } else {
            userpostlist2[scrapIndex].scrap_count = userpostlist2[scrapIndex].scrap_count! - 1
            sender.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 1.0), for: .normal)
            sender.titleLabel?.layer.shadowColor = UIColor.clear.cgColor
            sender.setTitle("담아감 \(gino(userpostlist2[scrapIndex].scrap_count))", for: .normal)
            userpostlist2[scrapIndex].scrap = nil
            model.scrapUnscrap(scrap: "unscrap", idx: gino(idx), token: gsno(token))
        }
    }
    
    @objc func goToComment(sender:UIButton ) {
        guard let dvc = storyboard?.instantiateViewController(withIdentifier: "commentView") as? CommentViewController else {
            return
        }
        dvc.commentindex = gino(userpostlist2[sender.tag].user_idx)
        navigationController?.pushViewController(dvc, animated: true)
    }

    
}
extension UserPostListViewController: UICollectionViewDelegateFlowLayout {
    
}


