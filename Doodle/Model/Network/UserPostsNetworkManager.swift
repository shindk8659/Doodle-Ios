//
//  UserPostsNetworkManager.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 11..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserPostsNetworkManager: NetworkDelegate{
    
    func netWorkingRequestUserPostData(usridx: Int ,header : String) {
        let token = [
            "token" : header
        ]
        
        let URL = "\(baseURL)/users/other/\(usridx)"
        Alamofire.request(URL , method: .get, parameters: nil, encoding: JSONEncoding.default, headers: token).responseObject{
            (response: DataResponse<UserPost>) in
            switch response.result{
            case .success :
                guard let value = response.result.value else {
                    print("안됨")
                    self.delegate.networkFailed(msg: "")
                    
                    return
                }
                if value.status == 200 {
                    if let results = value.result{
                        print("됨")
                        self.delegate.networkResultData(resultData: results, code:"200")
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

