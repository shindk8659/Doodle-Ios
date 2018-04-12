//
//  File.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 2..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import Foundation

protocol NetworkCallBack{
    func networkResultData(resultData: Any, code: String)
    
    func networkFailed(msg: Any?)
}

