//
//  Comment.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 11..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import Foundation
import ObjectMapper

class CommentSend: Mappable {
    var status: Int?
    var message: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
    }
}


class Comment: Mappable {
    var status: Int?
    var message: String?
    var result: CommentResultList?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        result <- map["result"]
    }
}

class CommentResultList : Mappable{
    var comments: [CommentList]?
    var doodle: CommentDoodle?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        comments <- map["comments"]
        doodle <- map["doodle"]
    }
}
class CommentList : Mappable {
    var idx: Int?
    var content: String?
    var created: String?
    var updated: String?
    var user_idx: Int?
    var doodle_idx:Int?
    var nickname:String?
    var profile:String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        idx <- map["idx"]
        content <- map["content"]
        created <- map["created"]
        updated <- map["updated"]
        user_idx <- map["user_idx"]
        doodle_idx <- map["doodle_idx"]
        nickname <- map["nickname"]
        profile <- map["profile"]
    }
}


class CommentDoodle :Mappable{
    var idx: Int?
    var nickname: String?
    var image: String?
    var scrap_count: Int?
    var comment_count: Int?
    var like_count:Int?
    var created: String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        idx <- map["idx"]
        nickname <- map["nickname"]
        image <- map["image"]
        scrap_count <- map["scrap_count"]
        comment_count <- map["comment_count"]
        like_count <- map["like_count"]
        created <- map["created"]
    }
}

