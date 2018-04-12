//
//  MyPost.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 7..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import Foundation
import ObjectMapper

class MyPost: Mappable {
    var status: Int?
    var message: String?
    var result: [MyPostList]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        result <- map["result"]
    }
}

class MyPostList : Mappable{
    var idx: Int?
    var created: String?
    var scrap_count: Int?
    var comment_count : Int?
    var like_count: Int?
    var image: String?
    var scraps:Int?
    var nickname: String?
    var profile: String?
    var user_idx: Int?
    var like: Int?
    var scrap: Int?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        nickname <- map["nickname"]
        idx <- map["idx"]
        created <- map["created"]
        scrap_count <- map["scrap_count"]
        comment_count <- map["comment_count"]
        like_count <- map["like_count"]
        image <- map["image"]
        scraps <- map["scraps"]
        profile <- map["profile"]
        user_idx <- map["user_idx"]
        like <- map["like"]
        scrap <- map["scraps"]
        
    }
}










