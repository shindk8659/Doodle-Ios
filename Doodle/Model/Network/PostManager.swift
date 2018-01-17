//
//  PostManager.swift
//  Doodle
//
//  Created by Leeseungsoo on 2018. 1. 9..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON

class PostManager : NetworkDelegate {
    
    func post(text: String, image: Data?, token: String) {
        let URL = "\(baseURL)/doodle/post"
        let text = text.data(using: .utf8)
        let header = [
            "token" : token
        ]
        Alamofire.upload(multipartFormData: {
            multipartFormData in
            multipartFormData.append(text!, withName: "text")
            multipartFormData.append(image!, withName: "image", fileName: "image.jpg", mimeType: "image/png")
        }, to: URL, method: .post, headers: header, encodingCompletion: {
            encodingResult in
            switch encodingResult{
            case .success(let upload, _, _):
                upload.responseData {
                    res in
                    switch res.result {
                    case .success:
                        if let results = res.result.value {
                            DispatchQueue.main.async(execute: {
                                self.delegate.networkResultData(resultData: results, code: "200")
                            })
                        }
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
            }//switch
        })
        
    }
    

    func dailyBackgroundImg(addURL: String, method: HTTPMethod,  header: HTTPHeaders? ,code:String) {
       
        
        Alamofire.request(baseURL + addURL, method: method, encoding: JSONEncoding.default, headers: header).responseObject{
            (response: DataResponse<DailyBackground>) in
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
                break
            }
        }
}

}
    

