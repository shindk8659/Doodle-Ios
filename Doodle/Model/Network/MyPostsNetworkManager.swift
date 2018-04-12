//
//  MyPostsNetworkManager.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 6..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MyPostsNetworkManager: NetworkDelegate{
    
    func netWorkingRequestData(addURL: String, method: HTTPMethod, parameter: [String:Int]?, header: String, code:String) {
        let token = [
            "token" : header
        ]
        Alamofire.request(baseURL + addURL, method: method, parameters: parameter, encoding: JSONEncoding.default, headers: token).responseObject{
            (response: DataResponse<MyPost>) in
            switch response.result{
            case .success :
                guard let value = response.result.value else {
                    self.delegate.networkFailed(msg: "")
                    return
                }
                if value.status == 200 {
                    if let results = value.result{
                        self.delegate.networkResultData(resultData: results, code: code)
                    }
                }
                
                break
            case .failure(let err) :
                print("네트워크 접속 실패")
                print(err.localizedDescription)
                break
            }
        }
    }
    func netWorkingRequestProfile(addURL: String, method: HTTPMethod, header: String, code:String) {
        let token = [
            "token" : header
        ]
        Alamofire.request(baseURL + addURL, method: method, encoding: JSONEncoding.default, headers: token).responseObject{
            (response: DataResponse<Profile>) in
            
            switch response.result{
            case .success :
                guard let value = response.result.value else {
                    self.delegate.networkFailed(msg: "")
                    return
                }
                if value.status == 200 {
                    if let results = value.result {
                        self.delegate.networkResultData(resultData: results, code: code)
                    }
                }
                
                break
            case .failure(let err) :
                
                print("네트워크 접속 실패")
                print(err.localizedDescription)
                self.delegate.networkFailed(msg: "")
                break
            }
        }
    }
}





