//
//  SettingViewController.swift
//  Doodle
//
//  Created by seunghwan Lee on 2018. 1. 13..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

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

