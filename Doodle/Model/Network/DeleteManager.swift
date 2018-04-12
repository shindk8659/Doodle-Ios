//
//  DeleteManager.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 13..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DeleteManager : NetworkDelegate {
    
    
    func Delete (idx: Int ,token: String, code : String) {
        let URL = "\(baseURL)/doodle/delete/\(idx)"
        let header = [
            "token" : token
        ]
        DispatchQueue.main.async(execute: {
            Alamofire.request(URL, method: .delete ,encoding: JSONEncoding.default, headers: header).responseObject{
                (response: DataResponse<DeleteVo>) in
                switch response.result {
                case .success:
                    guard let value = response.result.value else {
                        self.delegate.networkFailed(msg:"")
                        return
                    }
                    if value.status == 200 {
                        if let results = value.status{
                            self.delegate.networkResultData(resultData: results, code: code)
                        }
                    }
                case .failure(let err):
                    
                    print(err)
                    self.delegate.networkFailed(msg: "")
                    
                }
                
            }
        })
        
    }
    
    
    
    
}

