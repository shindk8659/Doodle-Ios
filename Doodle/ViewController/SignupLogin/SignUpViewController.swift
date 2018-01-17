//
//  SignUpViewController.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 1..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//


import UIKit
import SwiftyJSON

class SignUpViewController: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet var nameTxtFd: UITextField!
    @IBOutlet var emailTxtFd: UITextField!
    @IBOutlet var pwTxtFd: UITextField!
    @IBOutlet var confirmPwTxtFd: UITextField!
    
    @IBOutlet var duplicateNameChk: UILabel!
    @IBOutlet var duplicateEmailChk: UILabel!
    @IBOutlet var confirmPwChk: UILabel!
    
    @IBOutlet var nameChkMark: UIImageView!
    @IBOutlet var emailChkMark: UIImageView!
    @IBOutlet var pwChkMark: UIImageView!
    @IBOutlet var confirmPwChkMark: UIImageView!
    
    @IBOutlet var joinBtn: UIButton!
    @IBOutlet var exitBtn: UIButton!
    
    @IBOutlet var joinLabel: UILabel!
    @IBOutlet var joinStackView: UIStackView!
    @IBOutlet var stackViewConstraints: NSLayoutConstraint!
    @IBOutlet var imageViewConstraints: NSLayoutConstraint!
    @IBOutlet var joinConstraints: NSLayoutConstraint!
    
    
    var check = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        duplicateNameChk.isHidden = true
        duplicateEmailChk.isHidden = true
        confirmPwChk.isHidden = true
        nameChkMark.isHidden = true
        emailChkMark.isHidden = true
        pwChkMark.isHidden = true
        confirmPwChkMark.isHidden = true
        joinBtn.isEnabled = false
        
        // 사진 올리기
        profileImg.isUserInteractionEnabled = true
        let mainTap = UITapGestureRecognizer(target: self, action: #selector(handleTap_mainview))
        let imageTab = UITapGestureRecognizer(target: self, action: #selector(imgTabbed(_:)))
        profileImg.addGestureRecognizer(imageTab)
        view.addGestureRecognizer(mainTap)
        imageTab.delegate = self
        mainTap.delegate = self
        initAddTarget()
    
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    func initAddTarget(){
        joinBtn.addTarget(self, action: #selector(join), for: .touchUpInside)
        nameTxtFd.addTarget(self, action: #selector(isValid), for: .editingChanged)
        nameTxtFd.addTarget(self, action: #selector(duplicateCheck), for: .editingChanged)
        emailTxtFd.addTarget(self, action: #selector(isValid), for: .editingChanged)
        emailTxtFd.addTarget(self, action: #selector(duplicateCheck), for: .editingChanged)
        pwTxtFd.addTarget(self, action: #selector(isValid), for: .editingChanged)
        pwTxtFd.addTarget(self, action: #selector(confirmCheck), for: .editingDidEnd)
        confirmPwTxtFd.addTarget(self, action: #selector(isValid), for: .editingChanged)
        confirmPwTxtFd.addTarget(self, action: #selector(confirmCheck), for: .editingChanged)
    }
    
    @objc func duplicateCheck(_ sender: UITextField) {
        
        let model = SignupLoginManager(self)
        if sender == nameTxtFd {
            if !((sender.text?.isEmpty)!) {
                let name = gsno(nameTxtFd.text)
                model.nicknameCheck(nickname: name, flag: 1)
            }
        }
        else if sender == emailTxtFd {
            if !((sender.text?.isEmpty)!) {
                let email = gsno(emailTxtFd.text)
                model.emailCheck(email: email, flag: 2)
            }
        }
    }
    
    @objc func confirmCheck() {
        if (confirmPwTxtFd.text?.isEmpty)! {
            confirmPwChkMark.isHidden = true
        } else {
            confirmPwChkMark.isHidden = false
            if pwTxtFd.text == confirmPwTxtFd.text {
                confirmPwChk.isHidden = true
                confirmPwChkMark.isHidden = false
            }
            else {
                confirmPwChk.isHidden = false
                confirmPwChkMark.isHidden = true
            }
        }
        
    }
    @objc func isValid(){
        if (nameTxtFd.text?.isEmpty)! {
            nameChkMark.isHidden = true
        } else {
            nameChkMark.isHidden = false
        }
        
        if (emailTxtFd.text?.isEmpty)! {
            emailChkMark.isHidden = true
        } else {
            emailChkMark.isHidden = false
        }
        
        if (pwTxtFd.text?.isEmpty)! {
            pwChkMark.isHidden = true
        } else {
            pwChkMark.isHidden = false
        }

        
        if (nameTxtFd.text?.isEmpty)! || (pwTxtFd.text?.isEmpty)! || (emailTxtFd.text?.isEmpty)! || (confirmPwTxtFd.text?.isEmpty)! {
            self.joinBtn.isEnabled = false
        }
        else {
            self.joinBtn.isEnabled = true
        }
    }
    
    @objc func imgTabbed(_ sender: UITapGestureRecognizer){
        showImagePicker()
    }
    @IBAction func imageChange(_ sender: Any) {
        showImagePicker()
    }
    
    

    @objc func handleTap_mainview(){
        self.nameTxtFd.resignFirstResponder()
        self.emailTxtFd.resignFirstResponder()
        self.pwTxtFd.resignFirstResponder()
        self.confirmPwTxtFd.resignFirstResponder()
    }
    
    @objc func join() {
        let defaultImage = UIImage(named: "signUp_profileIcon")
        if profileImg.image == defaultImage {
            simpleAlert(title: "회원 가입", msg: "프로필 사진을 설정해주세요.")
            return
        }
        let model = SignupLoginManager(self)
        let nickname = gsno(nameTxtFd.text)
        let email = gsno(emailTxtFd.text)
        let pw1 = gsno(pwTxtFd.text)
        let pw2 = gsno(confirmPwTxtFd.text)
        let image = UIImageJPEGRepresentation(profileImg.image!, 1.0)
        
        model.signup(email: email, pw1: pw1, pw2: pw2, nickname: nickname, image: image)
    }
    
    

    @IBAction func BackBtn(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
extension SignUpViewController: UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: nameTxtFd))! || (touch.view?.isDescendant(of: emailTxtFd))! || (touch.view?.isDescendant(of: pwTxtFd))! || (touch.view?.isDescendant(of: confirmPwTxtFd))! {
            return false
        }
        else {
            return true
        }
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name:.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name:.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if check {
                joinConstraints.constant = -304
                imageViewConstraints.constant = -222
                stackViewConstraints.constant = -25
                exitBtn.isHidden = true
                check = false
                view.layoutIfNeeded()
        }
    }//회원가입 - 48(-256,-304) , 이미지뷰 - 62(-160,-222), 스택뷰 - 81(65,-16)
    @objc func keyboardWillHide(notification: NSNotification) {
            joinConstraints.constant = -256
            imageViewConstraints.constant = -160
            stackViewConstraints.constant = 20
            exitBtn.isHidden = false
            check = true
            view.layoutIfNeeded()
    }
}
//MARK:- Extension
extension SignUpViewController: NetworkCallBack
{
    func networkResultData(resultData: Any, code: String) {
        if code == "dup_name_ok" {
            duplicateNameChk.isHidden = true
            nameChkMark.isHidden = false
        }
        else if code == "dup_name_fail" {
            duplicateNameChk.isHidden = false
            nameChkMark.isHidden = true
        }
        if code == "dup_email_ok" {
            duplicateEmailChk.isHidden = true
            emailChkMark.isHidden = false
        }
        else if code == "dup_email_fail" {
            duplicateEmailChk.isHidden = false
            emailChkMark.isHidden = true
        }
        if code == "register" {
            presentingViewController?.dismiss(animated: true)
        }
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func showImagePicker()
    {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker:UIImagePickerController = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            print("editimage")
            self.profileImg.image = editedImage
            self.profileImg.contentMode = .scaleToFill
            
        }
        defer{
            self.dismiss(animated: true, completion: nil)
        }
    }
}
