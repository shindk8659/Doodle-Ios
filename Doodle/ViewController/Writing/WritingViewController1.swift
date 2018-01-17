//
//  WritingViewController1.swift
//  Doodle
//
//  Created by seunghwan Lee on 2018. 1. 6..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import UIKit

class WritingViewController1: UIViewController {
    
    let EditView = UINib(nibName: "EditView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! EditView
    let FilterView = UINib(nibName: "FilterView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! FilterView
    
    let imagePicker = UIImagePickerController()
    var keyboardHeight : CGFloat = 216
    var mergedImage : UIImage?
    var checkNumb = 0
    var checkNumb2 = 0
    var checkNumb3 = 0
    var checkNumb4 = 0
    var filterCheck = 0
    
    var postObject : PostObject?
    var back : [DailyBackgroundResult] = []
    let token = UserDefaults.standard.string(forKey: "token")
    
    
    @IBOutlet var backGroundImg: UIImageView!
    
    @IBOutlet var mainTextView: UITextView!
    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet var initialImgView: UIImageView!
    @IBOutlet var downBtn: UIBarButtonItem!
    
    @IBOutlet var imageFilter: UIImageView!
    
    @IBOutlet var toolBarBotConst: NSLayoutConstraint!
    @IBOutlet var filterLeadingConst: NSLayoutConstraint!
    @IBOutlet var saveViewBotConst: NSLayoutConstraint!
    
    @IBAction func backGroundImgTap(_ sender: Any) {
        print("Success")
        if checkNumb2 == 1 {
            EditView.removeFromSuperview()
            checkNumb2 = checkNumb2 - 1
            if checkNumb2 > 1 {
                checkNumb2 = checkNumb2 - 1
            }
        }
        if checkNumb3 == 0 {
            FilterView.removeFromSuperview()
            print("checknumb3 = \(checkNumb3) ")
        }
        if checkNumb4 == 0 {
            checkNumb4 = checkNumb4 + 1 // 수정중2
        }
        mainTextView.becomeFirstResponder()
        downBtn.image = UIImage(named: "writing_downicon")
        
        if filterCheck == 1 {
            navigationItem.rightBarButtonItem?.isEnabled = true///마지막 수정
            filterCheck = filterCheck - 1 ///
        }
    }
    
    @IBAction func saveViewTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func textEditBtn(_ sender: Any) {
        if checkNumb == 1 {
            EditView.frame = CGRect(x: 0, y: self.view.frame.size.height - keyboardHeight, width: self.view.frame.size.width, height: keyboardHeight)
            let windowCount = UIApplication.shared.windows.count
            print(windowCount)
            UIApplication.shared.windows[windowCount - 1].addSubview(EditView)
            if checkNumb2 == 0 {
                checkNumb2 = checkNumb2 + 1 //수정중
            }
        } else {
            EditView.frame = CGRect(x: 0, y: self.view.frame.size.height - keyboardHeight, width: self.view.frame.size.width, height: keyboardHeight)
            print("hegiht: \(self.view.frame.size.height)")
            toolBarBotConst.constant = -keyboardHeight
            self.view.addSubview(EditView)
            downBtn.image = UIImage(named: "writing_downicon")
            checkNumb4 = checkNumb4 + 1
            if checkNumb2 == 0 {
                checkNumb2 = checkNumb2 + 1 //수정중
            }
        }
        
        if checkNumb == 2 {
            EditView.frame = CGRect(x: 0, y: self.view.frame.size.height - keyboardHeight, width: self.view.frame.size.width, height: keyboardHeight)
            let windowCount = UIApplication.shared.windows.count
            print(windowCount)
            UIApplication.shared.windows[windowCount - 1].addSubview(EditView)
        }
    }
    
    @IBAction func myAlbumBtn(_ sender: Any) {
        self.openLibrary()
        downBtn.image = UIImage(named: "writing_downicon")
        if checkNumb == 0 && checkNumb2 == 0 {
            downBtn.image = UIImage(named: "writing_upicon")
        }
    }
    
    @IBAction func downBtn(_ sender: Any) {
        switch checkNumb4 {
        case 0 :  mainTextView.becomeFirstResponder()
        checkNumb4 = checkNumb4 + 1
        downBtn.image = UIImage(named: "writing_downicon")
        print(checkNumb4)
            //        case 1: downSubView()
            //        checkNumb4 = 0
        //            print(checkNumb4)
        default : downSubView()
        checkNumb4 = 0
        print(checkNumb4)
        }
//        downSubView()
    }
    
    //    @objc func backButtonPressed(_ sender: UIBarButtonItem){
    //        let alert = UIAlertController(title: "ddd", message: "dd", preferredStyle: .alert)
    //        present(alert, animated: true, completion: nil)
    //    }
    
    @IBAction func backgroundImgBtn(_ sender: Any) {
        backGroundImg.imageFromUrl(gsno(back[2].image), defaultImgPath: "")
    }
    
    
    
    override func viewDidLoad() {
        //backgroundimg 서버
        let networkManager = PostManager(self)
        networkManager.dailyBackgroundImg(addURL: "/doodle/get", method: .get, header:nil  ,code: "getBackGround")
        mainTextView.delegate = self // 메인 텍스트 뷰
        super.viewDidLoad()
        setNaviBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(complete))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.gray
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor.black
        UITextView.appearance().tintColor = UIColor.white
        coverImageHidden()
        EditView.delegate = self
        FilterView.delegate = self
        imagePicker.delegate = self
        
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWillHide), name: .UIKeyboardWillHide,
                                         object: nil)
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWillShow), name: .UIKeyboardWillShow,
                                         object: nil)
        
        EditView.sliderThumbChange()
        FilterView.sliderThumbChange()
        
        EditView.font1.addTarget(self, action: #selector(fontbuttonClicked), for: .touchUpInside)
        EditView.font2.addTarget(self, action: #selector(fontbuttonClicked), for: .touchUpInside)
        EditView.font3.addTarget(self, action: #selector(fontbuttonClicked), for: .touchUpInside)
        EditView.font4.addTarget(self, action: #selector(fontbuttonClicked), for: .touchUpInside)
        EditView.font5.addTarget(self, action: #selector(fontbuttonClicked), for: .touchUpInside)
        EditView.font6.addTarget(self, action: #selector(fontbuttonClicked), for: .touchUpInside)
        EditView.font7.addTarget(self, action: #selector(fontbuttonClicked), for: .touchUpInside)
        
        EditView.color1.addTarget(self, action: #selector(colorbuttonClicked), for: .touchUpInside)
        EditView.color2.addTarget(self, action: #selector(colorbuttonClicked), for: .touchUpInside)
        EditView.color3.addTarget(self, action: #selector(colorbuttonClicked), for: .touchUpInside)
        EditView.color4.addTarget(self, action: #selector(colorbuttonClicked), for: .touchUpInside)
        EditView.color5.addTarget(self, action: #selector(colorbuttonClicked), for: .touchUpInside)
        EditView.color6.addTarget(self, action: #selector(colorbuttonClicked), for: .touchUpInside)
        EditView.color7.addTarget(self, action: #selector(colorbuttonClicked), for: .touchUpInside)
        EditView.color8.addTarget(self, action: #selector(colorbuttonClicked), for: .touchUpInside)
        EditView.color9.addTarget(self, action: #selector(colorbuttonClicked), for: .touchUpInside)
        
        FilterView.defaultImage.addTarget(self, action: #selector(filterPicked), for: .touchUpInside)
        FilterView.fogFilterBtn.addTarget(self, action: #selector(filterPicked), for: .touchUpInside)
        FilterView.moonLightFilterBtn.addTarget(self, action: #selector(filterPicked), for: .touchUpInside)
        FilterView.dawnFilterBtn.addTarget(self, action: #selector(filterPicked), for: .touchUpInside)
        FilterView.latteFilterBtn.addTarget(self, action: #selector(filterPicked), for: .touchUpInside)
        FilterView.sunsetFilterBtn.addTarget(self, action: #selector(filterPicked), for: .touchUpInside)
        
    }
    func setNaviBar() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.title = "글작성"
    }
    
    @objc func keyboardWillShow(_ notification:NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height}
        print("keykeyboardHeight: \(keyboardHeight)")
        if checkNumb == 0 {
            checkNumb = checkNumb + 1
        }
        moveToolbarUp(with: notification)
        toolBarBotConst.constant = -keyboardHeight // 툴바 문제 해결
    }
    
    @objc func keyboardWillHide(_ notification:NSNotification) {
        if checkNumb == 1{
            checkNumb = checkNumb - 1
        }
        toolBarBotConst.constant = 0// 툴바 문제 해결
        moveToolbarDown(with: notification)
        EditView.frame.origin.y = self.view.frame.size.height
        if let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval {
            UIView.animate(withDuration: animationDuration, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    fileprivate func moveToolbarUp(with notification:NSNotification) {
        self.moveToolBar(isUp: true, with: notification)
    }
    
    fileprivate func moveToolbarDown(with notification:NSNotification) {
        self.moveToolBar(isUp: false, with: notification)
    }
    
    fileprivate func moveToolBar(isUp up:Bool, with notification:NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
            let animationOptions = UIViewAnimationOptions(rawValue: (userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).uintValue)
            
            let frame = self.toolBar.frame
            let rect:CGRect = CGRect(x: frame.origin.x,
                                     y: frame.origin.y + endFrame.size.height * (up ? -1 : 1),
                                     width: frame.size.width,
                                     height: frame.size.height)
            UIView.animate(withDuration: duration,
                           delay: 0.0,
                           options: animationOptions,
                           animations: { () -> Void in
                            self.toolBar.frame = rect
            }, completion: nil)
        }else{
        }
    }
    
    func downSubView() {
        if checkNumb == 1 {
            mainTextView.endEditing(true)
        } else if checkNumb == 1 && checkNumb2 == 1 {
            EditView.frame.origin.y = self.view.frame.size.height
            if checkNumb == 1 && checkNumb2 == 1{
                checkNumb = checkNumb - 1
                checkNumb2 = checkNumb2 - 1
            }
        } else if checkNumb == 0 && checkNumb2 == 1 {
            toolBarBotConst.constant = 0
            EditView.removeFromSuperview()
            if checkNumb2 == 1{
                checkNumb2 = checkNumb2 - 1
            }
        }
        downBtn.image = UIImage(named: "writing_upicon")
    }
    
    func coverImageHidden() {
        initialImgView.isHidden = false
        initialImgView.alpha = 1.0
        
        UIView.animate(withDuration: 0.5, delay: 1, options: [], animations: {
            self.initialImgView.alpha = 0.0
        }) { (finished: Bool) in
            self.initialImgView.isHidden = true
            self.downBtn.image = UIImage(named: "writing_upicon")
        }
    }
    
    func openLibrary(){
//        imagePicker.sourceType = .photoLibrary
//        present(imagePicker, animated: false, completion: nil)
        if checkNumb == 0 && checkNumb2 == 1 {
            toolBarBotConst.constant = 0
            EditView.removeFromSuperview()
            if checkNumb2 == 1{
                checkNumb2 = checkNumb2 - 1
            }
            downBtn.image = UIImage(named: "writing_upicon")
        }
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: false, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            backGroundImg.image = image
            FilterView.defaultImage.setImage(image, for: .normal)
            FilterView.defaultImg1.image = image
            FilterView.defaultImg2.image = image
            FilterView.defaultImg3.image = image
            FilterView.defaultImg4.image = image
            FilterView.defaultImg5.image = image
            print(info)
        }
        
        checkNumb = checkNumb + 1 // test
        dismiss(animated: true, completion: nil)
        
        FilterView.frame = CGRect(x: 0, y: self.view.frame.size.height - keyboardHeight, width: self.view.frame.size.width, height: keyboardHeight)
        self.view.addSubview(FilterView)
        navigationItem.rightBarButtonItem?.isEnabled = false
        filterCheck = filterCheck + 1
        //            let windowCount = UIApplication.shared.windows.count
        //            print(windowCount)
        //            UIApplication.shared.windows[windowCount - 1].addSubview(FilterView)
        
    }
    
    @objc func fontbuttonClicked(_ sender: AnyObject?) {
        if sender === EditView.font1 {
            mainTextView.font = UIFont(name: "NanumMyeongjo", size: (mainTextView.font?.pointSize)!)
        } else if sender === EditView.font2 {
            mainTextView.font = UIFont(name: "NanumBarunGothic", size: (mainTextView.font?.pointSize)!)
        } else if sender === EditView.font3 {
            mainTextView.font = UIFont(name: "NanumPen", size: (mainTextView.font?.pointSize)!)
        } else if sender === EditView.font4 {
            mainTextView.font = UIFont(name: "tvN Enjoystories", size: (mainTextView.font?.pointSize)!)
        } else if sender === EditView.font5 {
            mainTextView.font = UIFont(name: "Goyang", size: (mainTextView.font?.pointSize)!)
        } else if sender === EditView.font6 {
            mainTextView.font = UIFont(name: "Uhbee NaHyun", size: (mainTextView.font?.pointSize)!)
        } else if sender === EditView.font7 {
            mainTextView.font = UIFont(name: "BM YEONSUNG", size: (mainTextView.font?.pointSize)!)
        }
    }
    
    @objc func colorbuttonClicked(_ sender: AnyObject?) {
        if sender === EditView.color1 {
            mainTextView.textColor = UIColor(red: 0x00, green: 0x00, blue: 0x00)
        } else if sender === EditView.color2 {
            mainTextView.textColor = UIColor(red: 0xFF, green: 0xFF, blue: 0xFF)
        } else if sender === EditView.color3 {
            mainTextView.textColor = UIColor(red: 0xFF, green: 0xCE, blue: 0xCE)
        } else if sender === EditView.color4 {
            mainTextView.textColor = UIColor(red: 0xFC, green: 0xE0, blue: 0xBB)
        } else if sender === EditView.color5 {
            mainTextView.textColor = UIColor(red: 0xFF, green: 0xF8, blue: 0xC4)
        } else if sender === EditView.color6 {
            mainTextView.textColor = UIColor(red: 0xD4, green: 0xFF, blue: 0xC4)
        } else if sender === EditView.color7{
            mainTextView.textColor = UIColor(red: 0xC1, green: 0xFF, blue: 0xFA)
        } else if sender === EditView.color8{
            mainTextView.textColor = UIColor(red: 0xC4, green: 0xE2, blue: 0xFF)
        } else if sender === EditView.color9{
            mainTextView.textColor = UIColor(red: 0xF0, green: 0xBF, blue: 0xFF)
        }
    }
    
    @objc func filterPicked(_ sender: AnyObject?) {
        if sender === FilterView.defaultImage {
            filterLeadingConst.constant = 400
        } else {
            filterLeadingConst.constant = 0
            if sender === FilterView.fogFilterBtn {
                imageFilter.image = UIImage(named: "writing_filter1fog")
            } else if sender === FilterView.moonLightFilterBtn {
                imageFilter.image = UIImage(named: "writing_filter2moonlight")
            } else if sender === FilterView.dawnFilterBtn {
                imageFilter.image = UIImage(named: "writing_filter3dawn")
            } else if sender === FilterView.latteFilterBtn {
                imageFilter.image = UIImage(named: "writing_filter4latte")
            } else if sender === FilterView.sunsetFilterBtn {
                imageFilter.image = UIImage(named: "writing_filter5sunset")
            }
        }
    }
    
    @objc func complete() {
        downSubView()
        if checkNumb3 == 0 {
            FilterView.removeFromSuperview()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            UIGraphicsBeginImageContextWithOptions(CGSize.init(width: self.backGroundImg.frame.size.width, height: self.backGroundImg.frame.size.height), false, 0)
            CGRect(x: self.backGroundImg.frame.origin.x, y: self.backGroundImg.frame.origin.y, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
            self.view.drawHierarchy(in: CGRect(x: -self.backGroundImg.frame.origin.x, y: -self.backGroundImg.frame.origin.y, width: self.view.bounds.size.width, height: self.view.bounds.size.height), afterScreenUpdates: true)
            self.mergedImage = UIGraphicsGetImageFromCurrentImageContext()
            guard let img = self.mergedImage else {return}
            let model = PostManager(self)
            let text = self.mainTextView.text
            let image = UIImageJPEGRepresentation(img, 1.0)
            model.post(text: self.gsno(text), image: image, token: self.gsno(self.token))
            
            UIImageWriteToSavedPhotosAlbum(img, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
            
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.gray
            self.saveViewBotConst.constant = 0
            //            UIView.animate(withDuration: 0.5, animations: { [weak self] in
            //                self?.view.layoutIfNeeded()
            //                }, completion: { finish in
            //                    self.saveViewBotConst.constant = 1
            //                    UIView.animate(withDuration: 1, animations: { [weak self] in
            //                        self?.view.layoutIfNeeded()
            //                        }, completion: { finish in
            //                            self.navigationController?.popViewController(animated: true)
            //                    })
            //            })
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                self?.view.layoutIfNeeded()})
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                self.navigationController?.popViewController(animated: true)
            })
            
        })
        
        //        UIView.animate(withDuration: 0.5, animations: { [weak self] in
        //                        self?.view.layoutIfNeeded()
        //                        })
        //
        //        UIView.animate(withDuration: 0.5, delay: 1, options: [], animations: {
        //
        //        }) { (finished: Bool) in
        //            self.initialImgView.isHidden = true
        //            self.mainTextView.becomeFirstResponder()
        //            self.downBtn.image = UIImage(named: "writing_downicon")
        //        }
        //            self.navigationController?.popViewController(animated: true)
        //        UIView.animate(withDuration: 0.5, animations: { [weak self] in
        //            self?.view.layoutIfNeeded()
        //            }, completion: { finish in
        //               self.navigationController?.popViewController(animated: true)
        //        })
    }
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            //            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            //            ac.addAction(UIAlertAction(title: "OK", style: .default))
            //            present(ac, animated: true)
        }
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension WritingViewController1 : sliderDelegate, sliderAlphaDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func sliderValueData(data: CGFloat) {
        mainTextView.font = UIFont(name: (mainTextView.font?.fontName)!, size: data * 10)
        //        print("data: \(data)")
    }
    
    func sliderValueData2(data: CGFloat) {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = data 
        let attributes = [NSAttributedStringKey.paragraphStyle : style]
        mainTextView.attributedText = NSAttributedString(string: mainTextView.text, attributes:attributes)
        mainTextView.font = self.mainTextView.font
        mainTextView.textColor = self.mainTextView.textColor
        mainTextView.textAlignment = self.mainTextView.textAlignment
    }
    
    func sliderAlphaData(data: CGFloat) {
        imageFilter.alpha = data
        //        print(data)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty == false {
            navigationItem.rightBarButtonItem?.tintColor = UIColor.black
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.tintColor = UIColor.gray
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
        if textView.frame.width >= backGroundImg.frame.width - 5 {
            textView.leadingAnchor.constraint(equalTo: backGroundImg.leadingAnchor).isActive = true
            textView.trailingAnchor.constraint(equalTo: backGroundImg.trailingAnchor).isActive = true
        } else if textView.frame.width < backGroundImg.frame.width - 5 {
            textView.leadingAnchor.constraint(equalTo: backGroundImg.leadingAnchor).isActive = false
            textView.trailingAnchor.constraint(equalTo: backGroundImg.trailingAnchor).isActive = false
        }
        if textView.frame.height >= backGroundImg.frame.height - 5 {
            textView.topAnchor.constraint(equalTo: backGroundImg.topAnchor).isActive = true
            textView.bottomAnchor.constraint(equalTo: backGroundImg.bottomAnchor).isActive = true
        } else if textView.frame.height < backGroundImg.frame.height - 5{
            textView.topAnchor.constraint(equalTo: backGroundImg.topAnchor).isActive = false
            textView.bottomAnchor.constraint(equalTo: backGroundImg.bottomAnchor).isActive = false
        }
    }
}

extension WritingViewController1 : NetworkCallBack {
    func networkResultData(resultData: Any, code: String) {
        if code == "getBackGround" {
            back = resultData as! [DailyBackgroundResult]
            backGroundImg.imageFromUrl(gsno(back[2].image), defaultImgPath: "")
        }
    }
}

