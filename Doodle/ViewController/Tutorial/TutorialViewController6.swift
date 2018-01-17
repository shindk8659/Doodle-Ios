//
//  TutorialViewController6.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 4..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import UIKit

class TutorialViewController6: UIViewController {

    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    
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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToSignupBtn(_ sender: Any) {
        UserDefaults.standard.set("first", forKey: "first")
        performSegue(withIdentifier: "goToSignup", sender: self)
    }
    
    @IBAction func goToLoginBtn(_ sender: Any) {
        UserDefaults.standard.set("first", forKey: "first")
        performSegue(withIdentifier: "goToLogin", sender: self)
    }
    
    @IBAction func unwindAfterLogout(_ sender:UIStoryboardSegue) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
