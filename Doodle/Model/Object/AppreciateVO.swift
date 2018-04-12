//
//  AppreciateVO.swift
//  Doodle
//
//  Created by Leeseungsoo on 2018. 1. 12..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import ObjectMapper

class AppreciateVO : Mappable {
    var status : Int?
    var message : String?
    var result : [AppreciateResultVO]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        result <- map["result"]
    }
}

class AppreciateResultVO : Mappable {
    var idx : Int?
    var text : String?
    var image : String?
    var comment_count : Int?
    var scrap_count : Int?
    var like_count : Int?
    var user_idx : Int?
    var nickname : String?
    var like : Int?
    var scrap : Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        idx <- map["idx"]
        text <- map["text"]
        image <- map["image"]
        comment_count <- map["comment_count"]
        scrap_count <- map["scrap_count"]
        like_count <- map["like_count"]
        user_idx <- map["user_idx"]
        nickname <- map["nickname"]
        like <- map["like"]
        scrap <- map["scraps"]
    }
}
