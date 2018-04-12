//
//  DeleteVO.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 13..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import Foundation
import ObjectMapper

class DeleteVo : Mappable {
    var status : Int?
    var message : String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        
    }
}

