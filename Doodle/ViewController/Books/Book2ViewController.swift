//
//  Book2ViewController.swift
//  Doodle
//
//  Created by seunghwan Lee on 2018. 1. 13..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import UIKit

class Book2ViewController: UIViewController {

    @IBAction func sailBtn(_ sender: Any) {
        let alert = UIAlertController(title: "구매하기", message: "준비중입니다.", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
