//
//  LoginViewController.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 4..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController {
    
    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    
    var loginVO  : LoginObject?
    var loginProfileVO : LoginProfileObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

   
    @IBAction func LoginAction(_ sender: Any) {
        guard let email = EmailText.text else {return}
        guard let pw = PasswordText.text else {return}
        
        if(email == "")||(pw == "")
        {
            let alert = UIAlertController(title: "", message: "이메일과 비밀번호를 입력해주세요", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        let manager = SignupLoginManager(self)
        manager.login(email: email, pw: pw)
    }
    
}

extension LoginViewController: NetworkCallBack
{
    func networkResultData(resultData: Any, code: String) {
        if code == "login"{
            loginVO = resultData as? LoginObject
            loginProfileVO = loginVO?.profile
            let token = loginVO?.token
            let nickname = gsno(loginProfileVO?.nickname)
            UserDefaults.standard.set(token, forKey: "token")
            UserDefaults.standard.set(nickname, forKey: "nickname")
            let storyboard: UIStoryboard = UIStoryboard(name: "MainView", bundle: nil)
            let nextView = storyboard.instantiateViewController(withIdentifier: "NavigationVC")
            present(nextView, animated: true, completion: nil)
        }
        if code == "fail" {
            simpleAlert(title: "회원 정보 오류", msg: "이메일이나 비밀번호가 일치하지않습니다.")
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}


