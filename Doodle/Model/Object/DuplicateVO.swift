//
//  DuplicateVO.swift
//  Doodle
//
//  Created by Leeseungsoo on 2018. 1. 12..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import ObjectMapper

class DuplicateVO : Mappable {
    var status : Int?
    var message : String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
    }
    
}
