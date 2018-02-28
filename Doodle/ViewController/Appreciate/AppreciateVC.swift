//
//  AppreciateVC.swift
//  simplelab_180102
//
//  Created by Leeseungsoo on 2018. 1. 9..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class AppreciateVC : UIViewController , MFMailComposeViewControllerDelegate {
    
    @IBOutlet var appreciateTableView: UITableView!
    @IBOutlet var allMenuButton: UIButton!
    @IBOutlet var weekMenuButton: UIButton!
    @IBOutlet var todayMenuButton: UIButton!
    @IBOutlet var btnStackView: UIStackView!
    @IBOutlet var bottomTableView: UIView!
    
    var menuIndex = 0
    var likeIndex = 0
    var scrapIndex = 0
    var appreciateResultList : [AppreciateResultVO] = [AppreciateResultVO]()
    var likeScrapCountVO : LikeScrapCountVO?
    
    var point : CGPoint = CGPoint()
    
    let token = UserDefaults.standard.string(forKey: "token")
    let myNickname = UserDefaults.standard.string(forKey: "nickname")
    
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
        super.viewDidLoad()
        self.setNaviBar()
        getList(flag: -1, token: gsno(token))
        appreciateTableView.delegate = self
        appreciateTableView.dataSource = self
        bottomTableView.layer.shadowRadius = 3
        bottomTableView.layer.shadowOffset = CGSize(width: 0, height: 0)
        bottomTableView.layer.shadowColor = UIColor.init(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0).cgColor
        bottomTableView.layer.shadowOpacity = 0.5
        
        allMenuButton.titleLabel?.layer.shadowColor = UIColor.init(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0).cgColor
        allMenuButton.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 0)
        allMenuButton.titleLabel?.layer.shadowRadius = 1
        allMenuButton.titleLabel?.layer.shadowOpacity = 0.8
        weekMenuButton.titleLabel?.layer.shadowColor = UIColor.clear.cgColor
        weekMenuButton.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 0)
        weekMenuButton.titleLabel?.layer.shadowRadius = 1
        weekMenuButton.titleLabel?.layer.shadowOpacity = 0.8
        todayMenuButton.titleLabel?.layer.shadowColor = UIColor.clear.cgColor
        todayMenuButton.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 0)
        todayMenuButton.titleLabel?.layer.shadowRadius = 1
        todayMenuButton.titleLabel?.layer.shadowOpacity = 0.8
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setNaviBar() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.title = "감상하기"
    }
    
    @objc func getList(flag: Int, token: String) {
        let model = AppreciateManager(self)
        model.getAppreciate(flag: flag, token: token)
    }
    
    @IBAction func allMenuButton(_ sender: Any) {
        self.menuIndex = 0
        
        self.allMenuButton.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 1.0), for: .normal)
        self.weekMenuButton.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 0.5), for: .normal)
        self.todayMenuButton.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 0.5), for: .normal)
        allMenuButton.titleLabel?.layer.shadowColor = UIColor.init(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0).cgColor
        weekMenuButton.titleLabel?.layer.shadowColor = UIColor.clear.cgColor
        todayMenuButton.titleLabel?.layer.shadowColor = UIColor.clear.cgColor
        getList(flag: -1, token: gsno(token))
    }
    @IBAction func weekMenuIndex(_ sender: Any) {
        self.menuIndex = 1
        self.allMenuButton.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 0.5), for: .normal)
        self.weekMenuButton.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 1.0), for: .normal)
        self.todayMenuButton.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 0.5), for: .normal)
        allMenuButton.titleLabel?.layer.shadowColor = UIColor.clear.cgColor
        weekMenuButton.titleLabel?.layer.shadowColor = UIColor.init(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0).cgColor
        todayMenuButton.titleLabel?.layer.shadowColor = UIColor.clear.cgColor
        getList(flag: 1, token: gsno(token))
    }
    @IBAction func todayMenuIndex(_ sender: Any) {
        self.menuIndex = 2
        self.allMenuButton.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 0.5), for: .normal)
        self.weekMenuButton.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 0.5), for: .normal)
        self.todayMenuButton.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 1.0), for: .normal)
        allMenuButton.titleLabel?.layer.shadowColor = UIColor.clear.cgColor
        weekMenuButton.titleLabel?.layer.shadowColor = UIColor.clear.cgColor
        todayMenuButton.titleLabel?.layer.shadowColor = UIColor.init(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0).cgColor
        getList(flag: 2, token: gsno(token))
    }
    
    func todayDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .weekday], from: date)
        let weekdayDic = [ 1 : "일요일", 2 : "월요일", 3 : "화요일", 4 : "수요일", 5 : "목요일", 6 : "금요일", 7 : "일요일" ]
        let year =  components.year!
        let month = components.month!
        let day = components.day!
        let weekday = weekdayDic[components.weekday!]!
        let today = "\(year)년 \(month)월 \(day)일, \(weekday)"
        return today
    }
    @objc func likeUnlike(sender: UIButton) {
        let model = AppreciateManager(self)
        likeIndex = sender.tag
        
        let idx = appreciateResultList[likeIndex].idx
        if appreciateResultList[likeIndex].like == nil {
            print("like")
            appreciateResultList[likeIndex].like_count = appreciateResultList[likeIndex].like_count! + 1
            sender.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 1.0), for: .normal)
            sender.titleLabel?.layer.shadowColor = UIColor.init(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0).cgColor
            sender.setTitle("공감 \(gino(appreciateResultList[likeIndex].like_count))", for: .normal)
            appreciateResultList[likeIndex].like = idx
            model.likeUnlike(like: "like", idx: gino(idx), token: gsno(token))
        } else {
            print("unlike")
            appreciateResultList[likeIndex].like_count = appreciateResultList[likeIndex].like_count! - 1
            sender.setTitleColor(UIColor.init(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0), for: .normal)
            sender.titleLabel?.layer.shadowColor = UIColor.clear.cgColor
            sender.setTitle("공감 \(gino(appreciateResultList[likeIndex].like_count))", for: .normal)
            appreciateResultList[likeIndex].like = nil
            model.likeUnlike(like: "unlike", idx: gino(idx), token: gsno(token))
        }
    }
    @objc func scrapUnscrap(sender: UIButton) {
        
        let model = AppreciateManager(self)
        scrapIndex = sender.tag
        let idx = appreciateResultList[scrapIndex].idx
        if appreciateResultList[scrapIndex].nickname == myNickname {
            simpleAlert(title: "담아가기", msg: "자신의 글은 담을 수 없습니다.")
            return
        }
        if appreciateResultList[scrapIndex].scrap == nil {
            appreciateResultList[scrapIndex].scrap_count = appreciateResultList[scrapIndex].scrap_count! + 1
            sender.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 1.0), for: .normal)
            sender.titleLabel?.layer.shadowColor = UIColor.init(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0).cgColor
            sender.setTitle("담아감 \(gino(appreciateResultList[scrapIndex].scrap_count))", for: .normal)
            appreciateResultList[scrapIndex].scrap = idx
            model.scrapUnscrap(scrap: "scrap", idx: gino(idx), token: gsno(token))
        } else {
            appreciateResultList[scrapIndex].scrap_count = appreciateResultList[scrapIndex].scrap_count! - 1
            sender.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 1.0), for: .normal)
            sender.titleLabel?.layer.shadowColor = UIColor.clear.cgColor
            sender.setTitle("담아감 \(gino(appreciateResultList[scrapIndex].scrap_count))", for: .normal)
            appreciateResultList[scrapIndex].scrap = nil
            model.scrapUnscrap(scrap: "unscrap", idx: gino(idx), token: gsno(token))
        }
    }
    @objc func goToComment(sender: UIButton) {
        let profileIndex = sender.tag
        guard let dvc = storyboard?.instantiateViewController(withIdentifier: "commentView") as? CommentViewController else {
            return
        }
        dvc.commentindex = gino(appreciateResultList[profileIndex].idx)
        navigationController?.pushViewController(dvc, animated: true)
    }
    @objc func goToProfile(sender: UIButton) {
        let profileIndex = sender.tag
        guard let dvc = storyboard?.instantiateViewController(withIdentifier: "userpost") as? UserPostViewController else { return }
        dvc.userindex = gino(appreciateResultList[profileIndex].user_idx)
        navigationController?.pushViewController(dvc, animated: true)
    }
    
}

extension AppreciateVC : NetworkCallBack {
    func networkResultData(resultData: Any, code: String) {
        if code == "success_tableData" {
            appreciateResultList = resultData as! [AppreciateResultVO]
            appreciateTableView.reloadData()
        }
        if code == "success_like" {
            print("success_like_unlike")
            
        }
        if code == "success_scrap" {
            
        }
        if code == "success_comment" {
            
        }
    }
}

extension AppreciateVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if menuIndex < 2 {
            if indexPath.section == 0 {
                return 409
            }
            else {
                return 361
            }
        } else {
            if indexPath.section == 0 {
                return 48
            }
            else {
                return 361
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if menuIndex < 2 {
            if section == 0 {
                if appreciateResultList.count > 0 {
                    return 3
                }
                else {
                    return 0
                }
            }
            else {
                if appreciateResultList.count > 3 {
                    return appreciateResultList.count - 3
                }else{
                    return 0
                }
            }
        } else {
            if section == 0 {
                if appreciateResultList.count > 0 {
                    return 1
                }
                else {
                    return 1
                }
            }
            else {
                if appreciateResultList.count > 1{
                    return appreciateResultList.count
                }else{
                    return 0
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if menuIndex < 2 {
            if indexPath.section == 0 {
                let cell = appreciateTableView.dequeueReusableCell(withIdentifier: "RankAppreciateCell", for: indexPath) as! RankAppreciateCell
                let appreciateResult = appreciateResultList[indexPath.row]
                cell.rankLabel.text = "\(indexPath.row + 1)"
                cell.appreciateImage.imageFromUrl(gsno(appreciateResult.image), defaultImgPath: "")
                cell.gongGam.setTitle("공감 \(gino(appreciateResult.like_count))", for: .normal)
                cell.comment.setTitle("댓글 \(gino(appreciateResult.comment_count))", for: .normal)
                cell.scrap.setTitle("담아감 \(gino(appreciateResult.scrap_count))", for: .normal)
                cell.thisNickname.setTitle("\(gsno(appreciateResult.nickname))", for: .normal)
                
                if appreciateResult.like == appreciateResult.idx {
                    print(gino(appreciateResult.like_count))
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
                if appreciateResult.scrap == appreciateResult.idx {
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
                
                cell.gongGam.tag = indexPath.row
                cell.gongGam.addTarget(self, action: #selector(likeUnlike(sender:)), for: .touchUpInside)
                cell.scrap.tag = indexPath.row
                cell.scrap.addTarget(self, action: #selector(scrapUnscrap(sender:)), for: .touchUpInside)
                cell.comment.tag = indexPath.row
                cell.comment.addTarget(self, action: #selector(goToComment(sender:)), for: .touchUpInside)
                cell.thisNickname.tag = indexPath.row
                cell.thisNickname.addTarget(self, action: #selector(goToProfile(sender:)), for: .touchUpInside)
                cell.reportBtn.tag = indexPath.row
                cell.reportBtn.addTarget(self, action: #selector(editbuttonTapped(sender:)), for: .touchUpInside)
                
                return cell
            }
            else {
                let cell = appreciateTableView.dequeueReusableCell(withIdentifier: "AppreciateCell", for: indexPath) as! AppreciateCell
                //let index = indexPath.row
                let appreciateResult = appreciateResultList[indexPath.row + 3]
                cell.AppreciateImage.imageFromUrl(gsno(appreciateResult.image), defaultImgPath: "")
                cell.gongGam.setTitle("공감 \(gino(appreciateResult.like_count))", for: .normal)
                cell.comment.setTitle("댓글 \(gino(appreciateResult.comment_count))", for: .normal)
                cell.scrap.setTitle("담아감 \(gino(appreciateResult.scrap_count))", for: .normal)
                cell.thisNickname.setTitle("\(gsno(appreciateResult.nickname))", for: .normal)
                if appreciateResult.like == appreciateResult.idx {
                    print(gino(appreciateResult.like_count))
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
                if appreciateResult.scrap == appreciateResult.idx {
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
                cell.gongGam.tag = indexPath.row + 3
                cell.gongGam.addTarget(self, action: #selector(likeUnlike(sender:)), for: .touchUpInside)
                cell.scrap.tag = indexPath.row + 3
                cell.scrap.addTarget(self, action: #selector(scrapUnscrap(sender:)), for: .touchUpInside)
                cell.comment.tag = indexPath.row + 3
                cell.comment.addTarget(self, action: #selector(goToComment(sender:)), for: .touchUpInside)
                cell.thisNickname.tag = indexPath.row + 3
                cell.thisNickname.addTarget(self, action: #selector(goToProfile(sender:)), for: .touchUpInside)
                cell.reportBtn.tag = indexPath.row
                cell.reportBtn.addTarget(self, action: #selector(editbuttonTapped(sender:)), for: .touchUpInside)
                return cell
            }
        } else {
            if indexPath.section == 0 {
                let cell = appreciateTableView.dequeueReusableCell(withIdentifier: "TodayCell", for: indexPath) as! TodayCell
                let today : String = self.todayDate()
                cell.todayLabel.text = today
                return cell
            }
            else {
                let cell = appreciateTableView.dequeueReusableCell(withIdentifier: "AppreciateCell", for: indexPath) as! AppreciateCell
                let appreciateResult = appreciateResultList[indexPath.row]
                cell.AppreciateImage.imageFromUrl(gsno(appreciateResult.image), defaultImgPath: "")
                cell.gongGam.setTitle("공감 \(gino(appreciateResult.like_count))", for: .normal)
                cell.comment.setTitle("댓글 \(gino(appreciateResult.comment_count))", for: .normal)
                cell.scrap.setTitle("담아감 \(gino(appreciateResult.scrap_count))", for: .normal)
                cell.thisNickname.setTitle("\(gsno(appreciateResult.nickname))", for: .normal)
                if appreciateResult.like == appreciateResult.idx {
                    print(gino(appreciateResult.like_count))
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
                if appreciateResult.scrap == appreciateResult.idx {
                    print("담아갔음")
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
                cell.gongGam.tag = indexPath.row
                cell.gongGam.addTarget(self, action: #selector(likeUnlike(sender:)), for: .touchUpInside)
                cell.scrap.tag = indexPath.row
                cell.scrap.addTarget(self, action: #selector(scrapUnscrap(sender:)), for: .touchUpInside)
                cell.comment.tag = indexPath.row
                cell.comment.addTarget(self, action: #selector(goToComment(sender:)), for: .touchUpInside)
                cell.thisNickname.tag = indexPath.row
                cell.thisNickname.addTarget(self, action: #selector(goToProfile(sender:)), for: .touchUpInside)
                cell.reportBtn.tag = indexPath.row
                cell.reportBtn.addTarget(self, action: #selector(editbuttonTapped(sender:)), for: .touchUpInside)
                return cell
            }
        }
    }
    @objc func editbuttonTapped(sender:UIButton ) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        func mailfunc(){
            if MFMailComposeViewController.canSendMail(){
                print("sdfsdf")
                var reportUserIdx :Int = 0
                var reportIdx:Int = 0
                
                reportIdx = self.appreciateResultList[sender.tag].idx!
                reportUserIdx = self.appreciateResultList[sender.tag].user_idx!
                
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
        
        
        let reportAction = UIAlertAction(title: "신고 하기", style: .default, handler: {(alert: UIAlertAction!) in mailfunc()})
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in print("cancel")})
        
        alertController.addAction(reportAction)
        alertController.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion:{})
            
            
        }
        
    }
}
