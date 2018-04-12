//
//  SignupLoginManager.swift
//  Doodle
//
//  Created by Leeseungsoo on 2018. 1. 12..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class SignupLoginManager : NetworkDelegate {
    func signup(email: String, pw1: String, pw2: String, nickname: String, image: Data?)  {
        let URL = "\(baseURL)/users/register"
        let email = email.data(using: .utf8)
        let pw1 = pw1.data(using: .utf8)
        let pw2 = pw2.data(using: .utf8)
        let nickname = nickname.data(using: .utf8)
        if image == nil {
            
        } else {
            Alamofire.upload(multipartFormData: {
                multipartFormData in
                multipartFormData.append(email!, withName: "email")
                multipartFormData.append(pw1!, withName: "pw1")
                multipartFormData.append(pw2!, withName: "pw2")
                multipartFormData.append(nickname!, withName: "nickname")
                multipartFormData.append(image!, withName: "image", fileName: "image.jpg", mimeType: "image/png")
               }, to: URL, encodingCompletion: {
                encodingResult in
                switch encodingResult{
                case .success(let upload, _, _):
                    upload.responseData { response in
                        switch response.result {
                        case .success:
                            DispatchQueue.main.async(execute: {
                                print("postModel_successs")
                                self.delegate.networkResultData(resultData: "", code: "register")
                            })
                            
                        case .failure(let err):
                            print("upload Error : \(err)")
                            DispatchQueue.main.async(execute: {
                                self.delegate.networkFailed(msg: "")
                            })
                        }
                    }
                case .failure(let err):
                    print("network Error : \(err)")
                    self.delegate.networkFailed(msg: "")
                }
            })
        }
    }
    func nicknameCheck(nickname: String, flag: Int){
        let URL = "\(baseURL)/users/duplicates"
        
        let body : [String:Any] = [
            "nickname": nickname,
            "flag": flag
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<401).responseObject{
            (response:DataResponse<DuplicateVO>) in
            switch response.result{
            case .success:
                guard let Message = response.result.value else{
                    self.delegate.networkFailed(msg: "")
                    return
                }
                if Message.message == "success" {
                    self.delegate.networkResultData(resultData: "", code: "dup_name_ok")
                }
                else if Message.message == "1" {
                    self.delegate.networkResultData(resultData: "", code: "dup_name_fail")
                }
                else {
                    self.delegate.networkFailed(msg: "")
                }
            case .failure(let err):
                print(err)
                self.delegate.networkFailed(msg: "")
            }
        }
    }
    
    func emailCheck(email: String, flag: Int) {
        let URL = "\(baseURL)/users/duplicates"
        
        let body : [String:Any] = [
            "email": email,
            "flag": flag
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<401).responseObject{
            (response:DataResponse<DuplicateVO>) in
            switch response.result{
            case .success:
                guard let Message = response.result.value else{
                    self.delegate.networkFailed(msg: "")
                    return
                }
                if Message.message == "success" {
                    self.delegate.networkResultData(resultData: "", code: "dup_email_ok")
                }
                else if Message.message == "2" {
                    self.delegate.networkResultData(resultData: "", code: "dup_email_fail")
                }
                else {
                    self.delegate.networkFailed(msg: "")
                }
            case .failure(let err):
                print(err)
                self.delegate.networkFailed(msg: "")
            }
        }
        
    }
    
    
    
    func login(email: String, pw: String) {
        let URL = "\(baseURL)/users/login"
        let body = [
            "email" : email,
            "pw" : pw
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<404).responseObject {
            (response: DataResponse<LoginResultObject>) in
            switch response.result {
            case .success:
                guard let value = response.result.value else {
                    self.delegate.networkFailed(msg: "")
                    return
                }
                if value.status == 200 {
                    if let results = value.result {
                        self.delegate.networkResultData(resultData: results, code: "login")
                    }
                } else {
                    self.delegate.networkResultData(resultData: "", code: "fail")
                }
                
            case .failure(let err):
                self.delegate.networkFailed(msg: err)
            }
        }
    }
    
    func validation(token: String) {
        let URL = "\(baseURL)/users"
        let header = [
            "token" : token
        ]
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<405).responseObject {
            (response: DataResponse<LoginResultObject>) in
            switch response.result {
            case .success:
                guard let value = response.result.value else {
                    self.delegate.networkFailed(msg: "")
                    return
                }
                if value.status == 200 {
                    if let results = value.result {
                        self.delegate.networkResultData(resultData: results, code: "validation")
                    }
                } else if value.status == 401 {
                    self.delegate.networkResultData(resultData: "", code: "expiration")
                }
            case .failure(let err):
                self.delegate.networkFailed(msg: err)
            }
        }
    }
}
