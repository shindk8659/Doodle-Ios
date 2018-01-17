//
//  EditProfileNetworkManager.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 11..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class EditProfileNetworkManager: NetworkDelegate{
    func netWorkingRequestEditProfile(description: String, image: Data?, token: String ,code:String) {
        let URL = "\(baseURL)/users/modify"
        let flag = "2"
        guard let senddescription = description.data(using: .utf8)else{return}
        guard let sendflag = flag.data(using: .utf8)else{return}
        let header = [
            "token" : token
        ]
        Alamofire.upload(multipartFormData: {
            multipartFormData in
            multipartFormData.append(image!, withName: "image", fileName: "profileImg.jpg", mimeType: "image/png")
            multipartFormData.append(senddescription, withName: "description")
            multipartFormData.append(sendflag, withName:"flag")
        }, to: URL, method: .put, headers: header, encodingCompletion: {
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
            }
        })
    }
    
    
}

