//
//  CommentNetworkManager.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 11..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//




import Foundation
import Alamofire
import SwiftyJSON

class CommentNetworkManager: NetworkDelegate{
    
    
    func netWorkingRequestCommentGet(addURL: String, method: HTTPMethod, header: String, code:String, index: Int) {
        let token = [
            "token" : header
        ]
        let URL = "\(baseURL)\(addURL)/\(index)"
        Alamofire.request(URL, method: method, encoding: JSONEncoding.default, headers: token).responseObject{
            (response: DataResponse<Comment>) in
            
            switch response.result{
            case .success :
                guard let value = response.result.value else {
                    self.delegate.networkFailed(msg: "")
                    return
                }
                if value.status == 200 {
                    if let results = value.result {
                        //print("네트워크 접속 성공")
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
    func networkingRequestCommentSend(comment: String ,index: Int,header: String, code: String){
        let token = [
            "token" : header
        ]
        let parameter = [
            "content" : comment
        ]
        let URL = "\(baseURL)/comments/\(index)"
        Alamofire.request(URL, method: .post, parameters:parameter , encoding: JSONEncoding.default, headers: token).responseObject{
            (response: DataResponse<CommentSend>) in
            
            switch response.result{
            case .success :
                guard let value = response.result.value else {
                    self.delegate.networkFailed(msg: "")
                    return
                }
                if value.status == 200 {
                    
                    print("네트워크 접속 성공")
                    self.delegate.networkResultData(resultData: value, code: "commentsend")
                    
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



