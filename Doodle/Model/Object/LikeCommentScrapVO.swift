//
//  LikeCommentScrapVO.swift
//  Doodle
//
//  Created by Leeseungsoo on 2018. 1. 12..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import ObjectMapper

class LikeCommentScrapVO : Mappable {
    var status : Int?
    var message : String?
    var result : LikeScrapCountVO?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        result <- map["result"]
    }
}

class LikeScrapCountVO : Mappable {
    var count : Int?
    var idx : String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        count <- map["count"]
        idx <- map["idx"]
    }
}
