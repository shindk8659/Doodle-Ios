//
//  AppreciateManager.swift
//  Doodle
//
//  Created by Leeseungsoo on 2018. 1. 12..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import SwiftyJSON

class AppreciateManager : NetworkDelegate {
    
    func getAppreciate (flag: Int, token: String) {
        let URL = "\(baseURL)/doodle/all"
        let body : [String:Int] = [
            "flag": flag
        ]
        let header = [
            "token" : token
        ]
        DispatchQueue.main.async(execute: {
            Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseObject{
                (response: DataResponse<AppreciateVO>) in
                switch response.result {
                case .success:
                    guard let value = response.result.value else {
                        self.delegate.networkFailed(msg:"")
                        return
                    }
                    if value.status == 200 {
                        if let results = value.result {
                            self.delegate.networkResultData(resultData: results, code: "success_tableData")
                        }
                    }
                case .failure(let err):
                    print(err)
                    self.delegate.networkFailed(msg: "")
                    
                }
                
            }
        })
        
    }
    func search(flag: Int, keyword: String, token: String) {
        var thisURL = "\(baseURL)/search"
        if flag == 0 {
            thisURL += "/users/\(keyword)"
        } else {
            thisURL += "/doodle/\(keyword)"
        }
        let encoded = thisURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let encodedURL = URL(string: encoded)
        let token = [
            "token" : token
        ]
        Alamofire.request(encodedURL!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: token).responseObject{
            (response: DataResponse<SearchVO>) in
            
            switch response.result {
            case .success:
                guard let value = response.result.value else {
                    self.delegate.networkFailed(msg: "")
                    return
                }
                if value.status == 200 {
                    if let results = value.result {
                        self.delegate.networkResultData(resultData: results, code: "search")
                    }
                }
            case .failure(let err):
                print(err)
                self.delegate.networkFailed(msg: "")
                
            }
        }
    }
    
    func likeUnlike(like: String, idx: Int, token: String) {
        let URL = "\(baseURL)/like/\(idx)"
        let body = [
            "like" : like
        ]
        let token = [
            "token" : token
        ]
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: token).responseObject{
            (response: DataResponse<LikeCommentScrapVO>) in
            
            switch response.result {
            case .success:
                guard let value = response.result.value else {
                    self.delegate.networkFailed(msg: "")
                    return
                }
                if value.status == 200 {
                    if let results = value.result {
                        self.delegate.networkResultData(resultData: results, code: "success_like")
                    }
                }
            case .failure(let err):
                print(err)
                self.delegate.networkFailed(msg: "")
                
            }
        }
    }
    func scrapUnscrap(scrap: String, idx: Int, token: String) {
        let URL = "\(baseURL)/scrap/\(idx)"
        let body = [
            "scrap" : scrap
        ]
        let token = [
            "token" : token
        ]
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: token).responseObject{
            (response: DataResponse<LikeCommentScrapVO>) in
            
            switch response.result {
            case .success:
                guard let value = response.result.value else {
                    self.delegate.networkFailed(msg: "")
                    return
                }
                if value.status == 200 {
                    if let results = value.result {
                        self.delegate.networkResultData(resultData: results, code: "success_scrap")
                    }
                }
            case .failure(let err):
                print(err)
                self.delegate.networkFailed(msg: "")
                
            }
        }
    }
}
