//
//  SettingViewController.swift
//  Doodle
//
//  Created by seunghwan Lee on 2018. 1. 13..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBAction func DeleteBtn(_ sender: Any) {
        let alert = UIAlertController(title: "계정탈퇴", message: "준비중입니다.", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func changeNickname(_ sender: Any) {
        let alert = UIAlertController(title: "필명 변경", message: "준비중입니다.", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func changeEmail(_ sender: Any) {
        let alert = UIAlertController(title: "이메일 변경", message: "준비중입니다.", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func changePassword(_ sender: Any) {
        
        let alert = UIAlertController(title: "비밀번호 변경", message: "준비중입니다.", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func reportuseropBtn(_ sender: Any) {
        let alert = UIAlertController(title: "의견보내기", message: "준비중입니다.", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNaviBar() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.title = "설정"
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        logoutAlert(title: "글적", message: "로그아웃 하시겠습니까?")
    }
    

}
extension UIViewController{
    
    func logoutAlert(title:String, message msg:String){
        
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        
        let okAction = UIAlertAction(title: "확인", style: .default){
            
            (_) in
            UserDefaults.standard.removeObject(forKey: "token")
            UserDefaults.standard.removeObject(forKey: "ncikname")
            self.performSegue(withIdentifier: "unwindAfterLogout", sender: self)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .default)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert,animated:true)
        
        
    }
    
    
}

