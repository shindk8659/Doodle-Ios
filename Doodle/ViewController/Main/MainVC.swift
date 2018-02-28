//
//  MainVC.swift
//  Doodle
//
//  Created by Leeseungsoo on 2018. 1. 12..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import UIKit

class MainVC: UIViewController{
    
   
    @IBAction func alertBtn(_ sender: Any) {
        let alert = UIAlertController(title: "알람", message: "준비중입니다.", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    @IBOutlet var postViewBtn: UIButton!
    @IBOutlet var appreciateViewBtn: UIButton!
    @IBOutlet var mypageViewBtn: UIButton!
    @IBOutlet var bookViewBtn: UIButton!
    
    
    override func viewDidLoad() {
        let textAttributes = [NSAttributedStringKey.font: UIFont(name: "NanumMyeongjo", size: 18)!, NSAttributedStringKey.foregroundColor:UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 1.0)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 1.0)
        navigationItem.title = "글적"
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        self.btnSetting()
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    
    func btnSetting() {
        postViewBtn.applyBtn()
        appreciateViewBtn.applyBtn()
        mypageViewBtn.applyBtn()
        bookViewBtn.applyBtn()
        postViewBtn.addTarget(self, action: #selector(setOpacity(button:)), for: .touchDown)
        postViewBtn.addTarget(self, action: #selector(unsetOpacity(button:)), for: .touchUpInside)
        postViewBtn.addTarget(self, action: #selector(unsetOpacity(button:)), for: .touchDragExit)
        appreciateViewBtn.addTarget(self, action: #selector(setOpacity(button:)), for: .touchDown)
        appreciateViewBtn.addTarget(self, action: #selector(unsetOpacity(button:)), for: .touchUpInside)
        appreciateViewBtn.addTarget(self, action: #selector(unsetOpacity(button:)), for: .touchDragExit)
        mypageViewBtn.addTarget(self, action: #selector(setOpacity(button:)), for: .touchDown)
        mypageViewBtn.addTarget(self, action: #selector(unsetOpacity(button:)), for: .touchUpInside)
        mypageViewBtn.addTarget(self, action: #selector(unsetOpacity(button:)), for: .touchDragExit)
        bookViewBtn.addTarget(self, action: #selector(setOpacity(button:)), for: .touchDown)
        bookViewBtn.addTarget(self, action: #selector(unsetOpacity(button:)), for: .touchUpInside)
        bookViewBtn.addTarget(self, action: #selector(unsetOpacity(button:)), for: .touchDragExit)
    }
    
    @objc func setOpacity(button: UIButton!) {
        if button == postViewBtn {
            button.setBackgroundImage(#imageLiteral(resourceName: "mainpage_tileimage1"), for: .normal)
        }
        else if button == appreciateViewBtn {
            button.setBackgroundImage(#imageLiteral(resourceName: "mainpage_tileimage2"), for: .normal)
        }
        else if button == mypageViewBtn {
            button.setBackgroundImage(#imageLiteral(resourceName: "mainpage_tileimage3"), for: .normal)
        }
        else if button == bookViewBtn {
            button.setBackgroundImage(#imageLiteral(resourceName: "mainpage_tileimage4"), for: .normal)
        }
    }
    @objc func unsetOpacity(button: UIButton!) {
        if button == postViewBtn {
            button.setBackgroundImage(#imageLiteral(resourceName: "mainpage_tile1"), for: .normal)
        }
        else if button == appreciateViewBtn {
            button.setBackgroundImage(#imageLiteral(resourceName: "mainpage_tile2"), for: .normal)
        }
        else if button == mypageViewBtn {
            button.setBackgroundImage(#imageLiteral(resourceName: "mainpage_tile3"), for: .normal)
        }
        else if button == bookViewBtn {
            button.setBackgroundImage(#imageLiteral(resourceName: "mainpage_tile4"), for: .normal)
        }
    }
}

extension UIButton {
    func applyBtn() {
        self.adjustsImageWhenHighlighted = false
        self.layer.shadowRadius = 7
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.titleLabel?.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.titleLabel?.layer.shadowRadius = 4
        self.titleLabel?.layer.shadowOpacity = 0.5
        self.titleLabel?.layer.shadowColor = UIColor.darkGray.cgColor
    }
}

