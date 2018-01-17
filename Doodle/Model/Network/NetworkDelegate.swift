//
//  NetworkDelegate.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 4..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON

class NetworkDelegate{
    
    internal let baseURL = "http://13.124.156.77:3000/api"
    var delegate: NetworkCallBack
    
    init(_ delegate: NetworkCallBack) {
        self.delegate = delegate
    }
}

