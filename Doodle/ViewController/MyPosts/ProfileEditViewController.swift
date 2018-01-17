//
//  ProfileEditViewController.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 11..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import UIKit

class ProfileEditViewController: UIViewController {
    
    
    var token = UserDefaults.standard.string(forKey: "token")
    
    @IBAction func changeBtn(_ sender: Any) {
        showImagePicker()
        
    }
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var mySentenceLabel: UITextField!
    
    
    var userDefaultsprofileImg = UserDefaults.standard.string(forKey: "profileImg")
    var userDefaultsprofileDescription = UserDefaults.standard.string(forKey: "profileDescription")
    
    @IBAction func sendEditProfile(_ sender: Any) {
        
        guard let image = profileImg.image else{return}
        let jpegImage = UIImageJPEGRepresentation(image, 1.0)
        
        let description:String = gsno(mySentenceLabel.text)
        let code = "profile"
        let header = gsno(token)
        
        let networkManager = EditProfileNetworkManager(self)
        networkManager.netWorkingRequestEditProfile(description: description, image: jpegImage, token: header ,code:code)
        
    }
    
    override func viewDidLoad() {
        profileImg.isUserInteractionEnabled = true
        let tab = UITapGestureRecognizer(target: self, action: #selector(imgTabbed(_:)))
        profileImg.addGestureRecognizer(tab)
        
        profileImg.imageFromUrl(userDefaultsprofileImg, defaultImgPath: "")
        mySentenceLabel.text = userDefaultsprofileDescription
        
        setNaviBar()
        super.viewDidLoad()
        
    }
    @objc func imgTabbed(_ sender: UITapGestureRecognizer){
        showImagePicker()
    }
    
    func setNaviBar() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.title = "프로필 수정"
    }
    
    
}
extension ProfileEditViewController: NetworkCallBack{
    func networkResultData(resultData: Any, code: String) {
        if code == "200"{
            
            
            navigationController?.popViewController(animated: true)
            
            
        }
    }
    
   
    
}
extension ProfileEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
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
            self.profileImg.image = editedImage
            self.profileImg.contentMode = .scaleToFill
        }
        
        defer{
            self.dismiss(animated: true, completion: nil)
        }
    }
}
