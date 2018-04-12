//
//  SearchVO.swift
//  Doodle
//
//  Created by Leeseungsoo on 2018. 1. 12..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import ObjectMapper

class SearchVO : Mappable {
    
    var status : Int?
    var message : String?
    var result : [SearchResultVO]?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        result <- map["result"]
    }
}

class SearchResultVO : Mappable {
    var nickname : String?
    var description : String?
    var text : String?
    var idx : Int?
    var image : String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        nickname <- map["nickname"]
        description <- map["description"]
        text <- map["text"]
        idx <- map["idx"]
        image <- map["image"]
    }
}
