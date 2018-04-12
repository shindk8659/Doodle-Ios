//
//  SplashVC.swift
//  Doodle
//
//  Created by Leeseungsoo on 2018. 1. 12..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import Foundation

import UIKit

class SplashVC : UIViewController, NetworkCallBack {
    
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    
    var delayInSeconds = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.layer.shadowRadius = 4
        mainLabel.layer.shadowColor = UIColor.init(red: 125.0/255.0, green: 125.0/255.0, blue: 125.0/255.0, alpha: 1.0).cgColor
        mainLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        mainLabel.layer.shadowOpacity = 1.0
        subLabel.layer.shadowRadius = 4
        subLabel.layer.shadowColor = UIColor.init(red: 125.0/255.0, green: 125.0/255.0, blue: 125.0/255.0, alpha: 1.0).cgColor
        subLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        subLabel.layer.shadowOpacity = 1.0
        autoLoginAndSplash()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func autoLoginAndSplash () {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            if let firstUser = UserDefaults.standard.string(forKey: "first") {
                print(firstUser)
                if let token = UserDefaults.standard.string(forKey: "token") {
                    let manager = SignupLoginManager(self)
                    manager.validation(token: token)
                } else {
                    let login_storyboard = UIStoryboard(name: "TutorialLogin", bundle: nil)
                    guard let loginVC = login_storyboard.instantiateViewController(withIdentifier: "6") as? TutorialViewController6 else {return}
                    self.present(loginVC, animated: true, completion: nil)
                }
            } else {
                let tuto_storyboard = UIStoryboard(name: "TutorialLogin", bundle: nil)
                guard let tutorialVC = tuto_storyboard.instantiateViewController(withIdentifier: "YourPageVC") as? PageViewController else {return}
                self.present(tutorialVC, animated: true, completion: nil)
                
            }
        }
    }
    
    func networkResultData(resultData: Any, code: String) {
        if code == "validation" {
            let main_storyboard = UIStoryboard(name: "MainView", bundle: nil)
            let mainVC = main_storyboard.instantiateViewController(withIdentifier: "NavigationVC")
            present(mainVC, animated: true)
        } else if code == "expiration" {
            let login_storyboard = UIStoryboard(name: "TutorialLogin", bundle: nil)
            guard let loginVC = login_storyboard.instantiateViewController(withIdentifier: "6") as? TutorialViewController6 else {return}
            present(loginVC, animated: true, completion: nil)
        }
    }
}
